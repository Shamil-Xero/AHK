#Requires AutoHotkey v2.0

class DynamicNumpad {
    ; Configuration properties
    settingsFile := "numpad_settings.ini"
    iniFile := ""
    mode := 1
    timeout := 5
    settings := Map()

    ; GUI elements
    gui := ""
    titleBar := ""
    buttons := Map()
    pictures := Map()
    buttonBackgrounds := Map()
    buttonIndex := Map()

    ; State tracking
    buttonImages := Map()
    isImageSet := Map()
    fadeTimer := 0
    isSelectingImage := false
    shouldFadeOut := false

    /**
     * Create a new DynamicNumpad instance
     * @param {String} iniFile - Optional path to custom INI file
     * @param {Integer} timeout - Seconds before GUI automatically fades out (-1 to disable)
     * @param {Integer} mode - Which mode/layer to display (1-4)
     */
    __New(iniFile := "", timeout := -1, mode := 1) {
        this.mode := mode
        this.LoadSettings()

        ; Override settings with parameters if provided
        if (iniFile != "")
            this.iniFile := iniFile
        else
            this.iniFile := this.settings["ImagesIniFile" this.mode]

        if (timeout != -1)
            this.timeout := timeout
        else
            this.timeout := this.settings["Timeout"]

        this.CreateGUI()
        this.CreateButtons()
        this.LoadImagesFromIni()
        this.ShowGUI()
    }

    /**
     * Load settings from INI file, create with defaults if not exists
     */
    LoadSettings() {
        ; Default settings
        this.settings := Map(
            "WindowX", 0,
            "WindowY", A_ScreenHeight - 500,
            "WindowWidth", 400,
            "WindowHeight", 500,
            "Transparency", 70,
            "BackgroundColor", "1a1a1a",
            "TitleBarColor", "2d2d2d",
            "ButtonColor", "2d2d2d",
            "ButtonBackgroundColor", "3d3d3d",
            "FontSize", 12,
            "FontName", "Arial",
            "ButtonSize", 80,
            "ImagesIniFile1", "numpad_images.ini",
            "ImagesIniFile2", "numpad_images2.ini",
            "ImagesIniFile3", "numpad_images3.ini",
            "ImagesIniFile4", "numpad_images4.ini",
            "Timeout", 5
        )

        ; Create INI file with default settings if it doesn't exist
        if (!FileExist(this.settingsFile)) {
            try {
                for key, value in this.settings {
                    IniWrite(value, this.settingsFile, "Settings", key)
                }
            } catch as e {
                MsgBox("Error creating settings file: " e.Message)
            }
        } else {
            ; Load settings from existing INI file
            try {
                for key in this.settings {
                    value := IniRead(this.settingsFile, "Settings", key)
                    if (value != "ERROR") {
                        if (IsNumber(value)) {
                            value := Number(value)
                        }
                        this.settings[key] := value
                    }
                }
            } catch as e {
                MsgBox("Error loading settings: " e.Message)
            }
        }
    }

    /**
     * Create the GUI window
     */
    CreateGUI() {
        this.gui := Gui("+AlwaysOnTop -Caption +ToolWindow -Border")
        this.gui.BackColor := this.settings["BackgroundColor"]
        this.gui.SetFont("s" this.settings["FontSize"] " bold", this.settings["FontName"])

        ; Add title bar for dragging
        this.titleBar := this.gui.Add("Text", "x0 y0 w" this.settings["WindowWidth"] " h30 Background" this.settings[
            "TitleBarColor"])
        this.titleBar.OnEvent("Click", this.DragWindow.Bind(this))

        this.gui.Opt("+LastFound")
        WinSetTransparent(0)  ; Start fully transparent
    }

    /**
     * Allow dragging the GUI by clicking on the title bar
     */
    DragWindow(thisGui, info) {
        if (info.MouseButton = "Left") {
            PostMessage(0xA1, 2, 0, , "A")  ; WM_NCLBUTTONDOWN
        }
    }

    /**
     * Show the GUI with fade-in animation
     */
    ShowGUI() {
        ; Position window based on settings
        xPos := this.settings["WindowX"]
        yPos := this.settings["WindowY"]
        this.gui.Show("x" xPos " y" yPos " w" this.settings["WindowWidth"] " h" this.settings["WindowHeight"] " Hide")

        ; Start fade-in animation
        this.FadeIn()

        ; Set timeout if specified
        if (this.timeout > 0) {
            this.shouldFadeOut := true
            this.fadeTimer := SetTimer(() => this.StartFadeOut(), -this.timeout * 1000)
        }
    }

    /**
     * Create the numpad buttons in the GUI
     */
    CreateButtons() {
        ; Button layout
        buttonLayout := [
            ["Num`nLock", 0, 0], ["/", 0, 1], ["*", 0, 2], ["-", 0, 3],
            ["7", 1, 0], ["8", 1, 1], ["9", 1, 2], ["+", 1, 3, 2],
            ["4", 2, 0], ["5", 2, 1], ["6", 2, 2],
            ["1", 3, 0], ["2", 3, 1], ["3", 3, 2], ["Enter", 3, 3, 2],
            ["0", 4, 0, 2], [".", 4, 2]
        ]

        buttonSpacing := 10
        totalWidth := this.settings["WindowWidth"]
        totalHeight := this.settings["WindowHeight"]
        baseButtonSize := this.settings["ButtonSize"]

        ; Calculate button size to fit window exactly
        buttonSize := (totalWidth - (buttonSpacing * 5)) / 4
        buttonHeight := (totalHeight - 30 - (buttonSpacing * 6)) / 5  ; Subtract title bar height and spacing

        ; Scale button size based on the setting
        scaleFactor := baseButtonSize / 80  ; 80 is the default size
        buttonSize *= scaleFactor
        buttonHeight *= scaleFactor

        for i, buttonInfo in buttonLayout {
            ; Parse button layout info
            if (buttonInfo.Length = 4) {
                text := buttonInfo[1]
                row := buttonInfo[2]
                col := buttonInfo[3]
                span := buttonInfo[4]
                rowspan := (row = 1 || row = 3) ? span : 1
                colspan := (row != 1 && row != 3) ? span : 1
            } else {
                text := buttonInfo[1]
                row := buttonInfo[2]
                col := buttonInfo[3]
                rowspan := 1
                colspan := 1
            }

            ; Calculate position and size
            x := col * (buttonSize + buttonSpacing) + buttonSpacing
            y := row * (buttonHeight + buttonSpacing) + buttonSpacing + 30  ; Add title bar height
            w := buttonSize * colspan + buttonSpacing * (colspan - 1)
            h := buttonHeight * rowspan + buttonSpacing * (rowspan - 1)

            ; Create button with background
            btn := this.gui.Add("Button", "x" x " y" y " w" w " h" h, text)
            btn.OnEvent("Click", (btn, *) => this.SelectImageForButton(btn.Text))
            btn.BackColor := this.settings["ButtonColor"]
            btn.SetFont("s" this.settings["FontSize"] " bold", this.settings["FontName"])

            ; Create background for picture
            bg := this.gui.Add("Text", "x" x " y" y " w" w " h" h " Hidden Background" this.settings[
                "ButtonBackgroundColor"])

            ; Create picture control
            pic := this.gui.Add("Picture", "x" x " y" y " w" w " h" h " Hidden")
            pic.OnEvent("Click", (pic, *) => this.SelectImageForButton(this.GetButtonTextFromPicture(pic)))

            this.buttons[text] := btn
            this.pictures[text] := pic
            this.buttonIndex[text] := i
            this.buttonBackgrounds[text] := bg
            this.isImageSet[text] := false
        }
    }

    /**
     * Get button text from a picture control
     */
    GetButtonTextFromPicture(pic) {
        for text, picture in this.pictures {
            if (picture = pic)
                return text
        }
        return ""
    }

    /**
     * Handle fade-in animation
     */
    FadeIn(alpha := 0) {
        if (alpha < this.settings["Transparency"]) {
            alpha += 5
            this.gui.Opt("+LastFound")
            WinSetTransparent(alpha)
            this.gui.Show()
            SetTimer(() => this.FadeIn(alpha), -20)
        } else {
            this.gui.Opt("+LastFound")
            WinSetTransparent(this.settings["Transparency"])
        }
    }

    /**
     * Start the fade-out animation
     */
    StartFadeOut() {
        if (!this.isSelectingImage && this.shouldFadeOut) {
            this.FadeOut(this.settings["Transparency"])
        }
    }

    /**
     * Handle fade-out animation
     */
    FadeOut(alpha) {
        if (this.isSelectingImage)
            return

        if (alpha > 0) {
            alpha -= 5
            try {
                this.gui.Opt("+LastFound")
                WinSetTransparent(alpha)
                SetTimer(() => this.FadeOut(alpha), -20)
            } catch {
                return  ; Exit if GUI no longer exists
            }
        } else {
            try {
                this.gui.Destroy()
            } catch {
                return  ; Exit if GUI no longer exists
            }
        }
    }

    /**
     * Show file picker and select an image for a button
     */
    SelectImageForButton(buttonText) {
        ; Don't allow multiple file picker dialogs
        if (this.isSelectingImage)
            return

        this.isSelectingImage := true
        this.shouldFadeOut := false  ; Prevent fade out while selecting

        ; Stop the fade timer if it's running
        if (this.fadeTimer) {
            SetTimer(this.fadeTimer, 0)
            this.fadeTimer := 0
        }

        ; Show file dialog
        selectedFile := FileSelect(1, , "Select image for " buttonText, "Image Files (*.png; *.jpg; *.jpeg; *.gif)")

        if (selectedFile) {
            try {
                ; Save image path to INI
                this.SaveImageToIni(buttonText, selectedFile)

                ; Update button with image
                this.buttonImages[buttonText] := selectedFile
                this.buttons[buttonText].Text := ""
                this.buttonBackgrounds[buttonText].Visible := true
                this.pictures[buttonText].Value := selectedFile
                this.pictures[buttonText].Visible := true
                this.buttons[buttonText].Visible := false
                this.isImageSet[buttonText] := true  ; Mark image as set
            } catch as e {
                MsgBox("Error loading image: " e.Message)
            }
        }

        this.isSelectingImage := false
        this.shouldFadeOut := true  ; Re-enable fade out

        ; Restart the fade timer if timeout was set
        if (this.timeout > 0) {
            this.fadeTimer := SetTimer(() => this.StartFadeOut(), -this.timeout * 1000)
        }
    }

    /**
     * Save image path to INI file
     */
    SaveImageToIni(buttonName, imagePath) {
        ; Convert display name to INI key name
        iniKey := buttonName = "Num`nLock" ? "NumLock" : buttonName

        ; Write to INI file using converted key name
        IniWrite(imagePath, this.iniFile, "Images", iniKey)
    }

    /**
     * Load saved images from INI file
     */
    LoadImagesFromIni() {
        if (!FileExist(this.iniFile)) {
            return
        }

        try {
            ; Read the Images section
            iniContent := IniRead(this.iniFile, "Images")
            if (!iniContent) {
                return
            }

            ; Split the content into lines and process each line
            for line in StrSplit(iniContent, "`n") {
                if (!line)
                    continue

                parts := StrSplit(line, "=")
                if (parts.Length != 2)
                    continue

                iniKey := parts[1]
                imagePath := parts[2]

                ; Convert INI key to display name
                buttonName := iniKey = "NumLock" ? "Num`nLock" : iniKey

                if (this.buttons.Has(buttonName) && FileExist(imagePath)) {
                    this.buttonImages[buttonName] := imagePath
                    this.buttons[buttonName].Text := ""
                    this.buttonBackgrounds[buttonName].Visible := true
                    this.pictures[buttonName].Value := imagePath
                    this.pictures[buttonName].Visible := true
                    this.buttons[buttonName].Visible := false
                    this.isImageSet[buttonName] := true  ; Mark image as set
                }
            }
        } catch as e {
            MsgBox("Error loading INI file: " e.Message)
        }
    }
}

; Parse command line arguments
args := A_Args
iniFile := ""
timeout := -1
mode := 1

for i, arg in args {
    if (arg = "--ini" && args.Has(i + 1)) {
        iniFile := args[i + 1]
    } else if (arg = "--timeout" && args.Has(i + 1)) {
        timeout := Integer(args[i + 1])
    } else if (arg = "--mode" && args.Has(i + 1)) {
        mode := Integer(args[i + 1])
    }
}

numpad := DynamicNumpad(iniFile, timeout, mode)