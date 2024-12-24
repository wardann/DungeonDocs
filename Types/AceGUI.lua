--- @class AceGUI
--- @field Create fun(self: table, widgetType: string, parent?: table): table # Creates a new widget
--- @field RegisterAsContainer fun(self: table, container: table): nil # Registers a container
--- @field RegisterAsWidget fun(self: table, widget: table): nil # Registers a widget
--- @field Release fun(self: table, widget: table): nil # Releases a widget back to the pool
--- @field widgets table<string, table> # Table of all registered widgets

--- @class AceGUIWidget
--- @field SetCallback fun(self: AceGUIWidget, callbackName: string, callback: fun(widget: AceGUIWidget, event: string, value: any)): nil Sets a callback for the widget.
--- @field Fire fun(self: AceGUIWidget, event: string, ...: any): nil Fires a custom event for the widget.
--- @field Release fun(self: AceGUIWidget): nil Releases the widget and cleans up its resources.
--- @field SetParent fun(self: AceGUIWidget, parent: AceGUIWidget): nil Sets the parent widget.
--- @field SetFullWidth fun(self: AceGUIWidget, isFull: boolean): nil # Sets whether the widget should take the full width of its parent container
--- @field SetFullHeight fun(self: AceGUIWidget, isFull: boolean): nil # Sets whether the widget should take the full height of its parent container

--- @class AceGUIContainer : AceGUIWidget
--- @field ReleaseChildren fun(self: AceGUIContainer): nil Releases all child widgets of the container.
--- @field AddChild fun(self: AceGUIContainer, child: AceGUIWidget): nil Adds a child widget to the container.
--- @field SetLayout fun(self: AceGUIContainer, layout: string): nil Sets the layout for arranging child widgets.

--- @class MultiLineEditBox : AceGUIWidget
--- @field SetText fun(self: MultiLineEditBox, text: string): nil Sets the text of the edit box.
--- @field GetText fun(self: MultiLineEditBox): string Gets the current text of the edit box.
--- @field SetWidth fun(self: MultiLineEditBox, width: number): nil Sets the width of the edit box.
--- @field SetHeight fun(self: MultiLineEditBox, height: number): nil Sets the height of the edit box.
--- @field SetLabel fun(self: MultiLineEditBox, label: string): nil Sets the label for the edit box.
--- @field SetDisabled fun(self: MultiLineEditBox, disabled: boolean): nil Enables or disables the edit box.
--- @field SetCallback fun(self: MultiLineEditBox, event: string, handler: fun(widget: MultiLineEditBox, event: string, ...): nil): nil Registers a callback for specific events.
--- @field ClearFocus fun(self: MultiLineEditBox): nil Clears the focus from the edit box.
--- @field SetFocus fun(self: MultiLineEditBox): nil Sets the focus to the edit box.
--- @field SetNumLines fun(self: MultiLineEditBox, numLines: number): nil # Sets the number of visible lines in the edit box
--- @field DisableButton fun(self: MultiLineEditBox, disabled: boolean): nil # Enables or disables the "Okay" button


--- @class TreeGroup : AceGUIContainer
--- @field SetTree fun(self: TreeGroup, tree: table): nil Sets the tree structure for the group.
--- @field SelectByPath fun(self: TreeGroup, ...: string): nil Selects a node in the tree by its path.
--- @field SetCallback fun(self: TreeGroup, event: string, handler: fun(widget: TreeGroup, event: string, ...): nil): nil Registers a callback for specific events.
--- @field SetWidth fun(self: TreeGroup, width: number): nil Sets the width of the tree group.
--- @field SetHeight fun(self: TreeGroup, height: number): nil Sets the height of the tree group.
--- @field SetLayout fun(self: TreeGroup, layout: string): nil Sets the layout style for the group.
--- @field SetTreeWidth fun(self: TreeGroup, treeWidth: number, isRelative?: boolean): nil # Sets the width of the tree panel.
--- @field SetSelected fun(self: TreeGroup, uniquevalue: string): nil # Sets the currently selected node in the tree.


--- @class SimpleGroup : AceGUIContainer
--- @field AddChild fun(self: SimpleGroup, widget: table): nil Adds a child widget to the group.
--- @field SetWidth fun(self: SimpleGroup, width: number): nil Sets the width of the group.
--- @field SetHeight fun(self: SimpleGroup, height: number): nil Sets the height of the group.
--- @field SetLayout fun(self: SimpleGroup, layout: string): nil Sets the layout style for the group.
--- @field frame Frame # The underlying WoW Frame object of the group


--- @class Label : AceGUIWidget
--- @field SetText fun(self: Label, text: string): nil Sets the text of the label.
--- @field GetText fun(self: Label): string Gets the current text of the label.
--- @field SetWidth fun(self: Label, width: number): nil Sets the width of the label.
--- @field SetHeight fun(self: Label, height: number): nil Sets the height of the label.
--- @field SetFont fun(self: Label, fontPath: string, fontSize: number): nil Sets the font of the label.
--- @field SetFontObject fun(self: Label, fontObject: Font): nil # Sets the font using a predefined font object.
--- @field label FontString # The underlying FontString object of the label.



--- @class ScrollFrame : AceGUIContainer
--- @field AddChild fun(self: ScrollFrame, widget: table): nil Adds a child widget to the scroll frame.
--- @field SetScroll fun(self: ScrollFrame, value: number): nil Sets the scroll position.
--- @field GetScroll fun(self: ScrollFrame): number Gets the current scroll position.
--- @field SetWidth fun(self: ScrollFrame, width: number): nil Sets the width of the scroll frame.
--- @field SetHeight fun(self: ScrollFrame, height: number): nil Sets the height of the scroll frame.


--- @class Button : AceGUIWidget
--- @field SetText fun(self: Button, text: string): nil Sets the text of the button.
--- @field GetText fun(self: Button): string Gets the current text of the button.
--- @field SetCallback fun(self: Button, event: string, handler: fun(widget: Button, event: string, ...): nil): nil Registers a callback for specific events.
--- @field SetWidth fun(self: Button, width: number): nil Sets the width of the button.
--- @field SetHeight fun(self: Button, height: number): nil Sets the height of the button.
--- @field SetDisabled fun(self: Button, disabled: boolean): nil Enables or disables the button.


--- @class AceGUIFrame : AceGUIContainer
--- @field SetTitle fun(self: AceGUIFrame, title: string): nil Sets the title of the frame.
--- @field SetStatusTable fun(self: AceGUIFrame, status: table): nil Sets the status table for persisting position and size across sessions.
--- @field EnableResize fun(self: AceGUIFrame, enable: boolean): nil Enables or disables resizing of the frame.
--- @field SetLayout fun(self: AceGUIFrame, layout: string): nil Sets the layout of the frame (e.g., "Flow", "List", etc.).
--- @field SetWidth fun(self: AceGUIFrame, width: number): nil Sets the width of the frame.
--- @field SetHeight fun(self: AceGUIFrame, height: number): nil Sets the height of the frame.
--- @field SetCallback fun(self: AceGUIFrame, event: string, callback: fun(widget: any, event: string, ...)): nil Sets a callback for a specified event.
--- @field AddChild fun(self: AceGUIFrame, child: any): nil Adds a child widget to the frame.
--- @field SetPoint fun(self: AceGUIFrame, point: string, relativeTo: any|nil, relativePoint: string, offsetX: number, offsetY: number): nil Sets the position of the frame.
--- @field Show fun(self: AceGUIFrame): nil Makes the frame visible.
--- @field Hide fun(self: AceGUIFrame): nil Hides the frame.
--- @field Release fun(self: AceGUIFrame): nil Releases the frame, returning it to the widget pool for reuse.
--- @field frame Frame The underlying WoW Frame object.
--- @field SetStatusText fun(self: AceGUIFrame, text: string): nil Sets the status text displayed in the frame's status bar.
--- @field SetAutoAdjustHeight fun(self: AceGUIFrame, autoAdjust: boolean): nil Enables or disables automatic height adjustment for the frame.



--- @class AceGUITabGroup : AceGUIContainer
--- @field SetTabs fun(self: AceGUITabGroup, tabs: table): nil Sets the tabs for the tab group.
--- @field SelectTab fun(self: AceGUITabGroup, tab: string): nil Selects a specific tab.
--- @field SetCallback fun(self: AceGUITabGroup, callbackName: string, callback: fun(widget: AceGUIContainer, event: string, value: any)): nil Sets a callback for the tab group.


--- @class InlineGroup : AceGUIContainer
--- @field SetTitle fun(self: InlineGroup, title: string): nil Sets the title of the inline group.
--- @field SetLayout fun(self: InlineGroup, layout: string): nil Sets the layout of the inline group.
--- @field AddChild fun(self: InlineGroup, widget: AceGUIWidget): nil Adds a child widget to the inline group.
--- @field ReleaseChildren fun(self: InlineGroup): nil Releases all child widgets.

--- @class CheckBox : AceGUIWidget
--- @field SetValue fun(self: CheckBox, value: boolean): nil # Sets the checkbox's value
--- @field GetValue fun(self: CheckBox): boolean # Gets the checkbox's current value
--- @field SetLabel fun(self: CheckBox, text: string): nil # Sets the checkbox's label text
--- @field SetDisabled fun(self: CheckBox, disabled: boolean): nil # Enables or disables the checkbox
--- @field SetCallback fun(self: CheckBox, event: string, callback: fun(event: string, widget: CheckBox, checked: boolean)): nil # Sets a callback for checkbox events

--- @class Slider : AceGUIWidget
--- @field SetValue fun(self: Slider, value: number): nil # Sets the slider's current value
--- @field GetValue fun(self: Slider): number # Gets the slider's current value
--- @field SetSliderValues fun(self: Slider, min: number, max: number, step: number): nil # Sets the slider's min, max, and step values
--- @field SetLabel fun(self: Slider, label: string): nil # Sets the label text for the slider
--- @field SetCallback fun(self: Slider, event: string, callback: fun(event: string, value: number, slider: Slider)): nil # Sets a callback for slider events


--- @class Dropdown : AceGUIWidget
--- @field SetList fun(self: Dropdown, list: table<string, string>, order?: table<number, string>): nil # Sets the dropdown list and optional order
--- @field AddItem fun(self: Dropdown, key: string, value: string): nil # Adds a single item to the dropdown
--- @field SetValue fun(self: Dropdown, value: string): nil # Sets the selected value
--- @field GetValue fun(self: Dropdown): string # Gets the selected value
--- @field SetText fun(self: Dropdown, text: string): nil # Sets the displayed text
--- @field SetLabel fun(self: Dropdown, text: string): nil # Sets the displayed label
--- @field SetCallback fun(self: Dropdown, event: string, callback: fun(event: string, widget: Dropdown, value: string)): nil # Sets a callback for dropdown events

--- @class ColorPicker : AceGUIWidget
--- @field SetColor fun(self: ColorPicker, r: number, g: number, b: number, a?: number): nil # Sets the selected color
--- @field GetColor fun(self: ColorPicker): number, number, number, number # Gets the current color (r, g, b, a)
--- @field SetLabel fun(self: ColorPicker, text: string): nil # Sets the label text for the color picker
--- @field SetCallback fun(self: ColorPicker, event: string, callback: fun(event: string, widget: ColorPicker, r: number, g: number, b: number, a: number)): nil # Sets a callback for color picker events

--- @class EditBox : AceGUIWidget
--- @field SetText fun(self: EditBox, text: string): nil # Sets the text in the edit box
--- @field GetText fun(self: EditBox): string # Gets the current text in the edit box
--- @field SetLabel fun(self: EditBox, label: string): nil # Sets the label for the edit box
--- @field SetDisabled fun(self: EditBox, disabled: boolean): nil # Enables or disables the edit box
--- @field SetCallback fun(self: EditBox, event: string, callback: fun(event: string, widget: EditBox, value: string)): nil # Sets a callback for edit box events
--- @field DisableButton fun(self: EditBox, disabled: boolean): nil # Enables or disables the clear button

