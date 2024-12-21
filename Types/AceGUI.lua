--- @class MultiLineEditBox
--- @field SetText fun(self: MultiLineEditBox, text: string): nil Sets the text of the edit box.
--- @field GetText fun(self: MultiLineEditBox): string Gets the current text of the edit box.
--- @field SetWidth fun(self: MultiLineEditBox, width: number): nil Sets the width of the edit box.
--- @field SetHeight fun(self: MultiLineEditBox, height: number): nil Sets the height of the edit box.
--- @field SetLabel fun(self: MultiLineEditBox, label: string): nil Sets the label for the edit box.
--- @field SetDisabled fun(self: MultiLineEditBox, disabled: boolean): nil Enables or disables the edit box.
--- @field SetCallback fun(self: MultiLineEditBox, event: string, handler: fun(widget: MultiLineEditBox, event: string, ...): nil): nil Registers a callback for specific events.
--- @field ClearFocus fun(self: MultiLineEditBox): nil Clears the focus from the edit box.
--- @field SetFocus fun(self: MultiLineEditBox): nil Sets the focus to the edit box.


--- @class TreeGroup
--- @field SetTree fun(self: TreeGroup, tree: table): nil Sets the tree structure for the group.
--- @field SelectByPath fun(self: TreeGroup, ...: string): nil Selects a node in the tree by its path.
--- @field SetCallback fun(self: TreeGroup, event: string, handler: fun(widget: TreeGroup, event: string, ...): nil): nil Registers a callback for specific events.
--- @field SetWidth fun(self: TreeGroup, width: number): nil Sets the width of the tree group.
--- @field SetHeight fun(self: TreeGroup, height: number): nil Sets the height of the tree group.
--- @field SetLayout fun(self: TreeGroup, layout: string): nil Sets the layout style for the group.


--- @class SimpleGroup
--- @field AddChild fun(self: SimpleGroup, widget: table): nil Adds a child widget to the group.
--- @field SetWidth fun(self: SimpleGroup, width: number): nil Sets the width of the group.
--- @field SetHeight fun(self: SimpleGroup, height: number): nil Sets the height of the group.
--- @field SetLayout fun(self: SimpleGroup, layout: string): nil Sets the layout style for the group.


--- @class Label
--- @field SetText fun(self: Label, text: string): nil Sets the text of the label.
--- @field GetText fun(self: Label): string Gets the current text of the label.
--- @field SetWidth fun(self: Label, width: number): nil Sets the width of the label.
--- @field SetHeight fun(self: Label, height: number): nil Sets the height of the label.
--- @field SetFont fun(self: Label, fontPath: string, fontSize: number): nil Sets the font of the label.


--- @class ScrollFrame
--- @field AddChild fun(self: ScrollFrame, widget: table): nil Adds a child widget to the scroll frame.
--- @field SetScroll fun(self: ScrollFrame, value: number): nil Sets the scroll position.
--- @field GetScroll fun(self: ScrollFrame): number Gets the current scroll position.
--- @field SetWidth fun(self: ScrollFrame, width: number): nil Sets the width of the scroll frame.
--- @field SetHeight fun(self: ScrollFrame, height: number): nil Sets the height of the scroll frame.


--- @class Button
--- @field SetText fun(self: Button, text: string): nil Sets the text of the button.
--- @field GetText fun(self: Button): string Gets the current text of the button.
--- @field SetCallback fun(self: Button, event: string, handler: fun(widget: Button, event: string, ...): nil): nil Registers a callback for specific events.
--- @field SetWidth fun(self: Button, width: number): nil Sets the width of the button.
--- @field SetHeight fun(self: Button, height: number): nil Sets the height of the button.
--- @field SetDisabled fun(self: Button, disabled: boolean): nil Enables or disables the button.


--- @class AceGUIFrame
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

--- @class AceGUIWidget
--- @field SetCallback fun(self: AceGUIWidget, callbackName: string, callback: fun(widget: AceGUIWidget, event: string, value: any)): nil Sets a callback for the widget.
--- @field Fire fun(self: AceGUIWidget, event: string, ...: any): nil Fires a custom event for the widget.
--- @field Release fun(self: AceGUIWidget): nil Releases the widget and cleans up its resources.
--- @field SetParent fun(self: AceGUIWidget, parent: AceGUIWidget): nil Sets the parent widget.

--- @class AceGUIContainer : AceGUIWidget
--- @field ReleaseChildren fun(self: AceGUIContainer): nil Releases all child widgets of the container.
--- @field AddChild fun(self: AceGUIContainer, child: AceGUIWidget): nil Adds a child widget to the container.
--- @field SetLayout fun(self: AceGUIContainer, layout: string): nil Sets the layout for arranging child widgets.

--- @class AceGUITabGroup : AceGUIContainer
--- @field SetTabs fun(self: AceGUITabGroup, tabs: table): nil Sets the tabs for the tab group.
--- @field SelectTab fun(self: AceGUITabGroup, tab: string): nil Selects a specific tab.
--- @field SetCallback fun(self: AceGUITabGroup, callbackName: string, callback: fun(widget: AceGUIContainer, event: string, value: any)): nil Sets a callback for the tab group.


--- @class AceGUIInlineGroup : AceGUIContainer
--- @field SetTitle fun(self: AceGUIInlineGroup, title: string): nil Sets the title of the inline group.
--- @field SetLayout fun(self: AceGUIInlineGroup, layout: string): nil Sets the layout of the inline group.
--- @field AddChild fun(self: AceGUIInlineGroup, widget: AceGUIWidget): nil Adds a child widget to the inline group.
--- @field ReleaseChildren fun(self: AceGUIInlineGroup): nil Releases all child widgets.
