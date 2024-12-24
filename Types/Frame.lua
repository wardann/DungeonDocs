--- @class Frame : UIObject
--- @field fontString FontString|nil A font string attached to the frame.
--- @field bg Texture|nil Background texture for the frame.
--- @field SetPoint fun(self: Frame, point: string, relativeTo: Frame|nil, relativePoint: string|nil, offsetX: number|nil, offsetY: number|nil): nil Sets the position of the frame.
--- @field SetSize fun(self: Frame, width: number, height: number): nil Sets the size of the frame.
--- @field EnableMouse fun(self: Frame, enable: boolean): nil Enables or disables mouse interactions for the frame.
--- @field SetMovable fun(self: Frame, movable: boolean): nil Sets whether the frame is movable.
--- @field GetPoint fun(self: Frame): string, Frame|nil, string, number, number Gets the position of the frame.
--- @field SetHeight fun(self: Frame, height: number): nil Sets the height of the frame.
--- @field GetHeight fun(self: Frame): number Gets the height of the frame.
--- @field SetWidth fun(self: Frame, width: number): nil Sets the width of the frame.
--- @field GetWidth fun(self: Frame): number Gets the width of the frame.
--- @field Hide fun(self: Frame): nil Hides the frame.
--- @field Show fun(self: Frame): nil Shows the frame.
--- @field IsShown fun(self: Frame): boolean Returns true if the frame is visible.
--- @field SetAlpha fun(self: Frame, alpha: number): nil Sets the alpha (transparency) of the frame.
--- @field GetAlpha fun(self: Frame): number Gets the alpha (transparency) of the frame.
--- @field CreateFontString fun(self: Frame, name: string|nil, layer: string|nil, template: string|nil): FontString Creates a new FontString and attaches it to the frame.
--- @field CreateTexture fun(self: Frame, name: string|nil, layer: string|nil, template: string|nil): Texture Creates a new Texture and attaches it to the frame.
--- @field RegisterForDrag fun(self: Frame, button: string): nil Registers the frame for drag events.
--- @field IsMovable fun(self: Frame): boolean Checks if the frame is movable.
--- @field GetLeft fun(self: Frame): number|nil Returns the x-coordinate of the left edge of the frame, or nil if the frame is not visible.
--- @field GetTop fun(self: Frame): number|nil Returns the y-coordinate of the top edge of the frame, or nil if the frame is not visible.
--- @field ClearAllPoints fun(self: Frame): nil Clears all anchor points set on the frame.
--- @field RegisterEvent fun(self: Frame, event: string): nil # Registers the frame for a specific event
--- @field UnregisterEvent fun(self: Frame, event: string): nil # Unregisters the frame from a specific event
--- @field SetScript fun(self: Frame, scriptType: string, handler: function): nil # Sets a script handler for the frame
--- @field GetChildren fun(self: Frame): Frame, ... # Returns the child frames as multiple return values.





--- @class FontString : Region
--- @field SetText fun(self: FontString, text: string): nil Sets the text of the font string.
--- @field GetText fun(self: FontString): string Gets the current text of the font string.
--- @field SetWordWrap fun(self: FontString, enable: boolean): nil Enables or disables word wrapping for the text.
--- @field GetPoint fun(self: FontString, index: number?): string, Region|nil, string|nil, number|nil, number|nil # Gets the anchor point at the specified index.
--- @field SetPoint fun(self: FontString, point: string, relativeTo?: Region, relativePoint?: string, offsetX?: number, offsetY?: number): nil # Sets the anchor point of the FontString.
--- @field SetJustifyH fun(self: FontString, align: string): nil Sets the horizontal alignment of the text (e.g., "LEFT", "CENTER", "RIGHT").
--- @field SetFont fun(self: FontString, fontPath: string, fontSize: number, flags?: string): nil # Sets the font, size, and style of the text.
--- @field GetFont fun(self: FontString): string, number, string # Gets the font path, font size, and style currently in use.
--- @field GetTextColor fun(self: FontString): number, number, number, number # Returns the red, green, blue, and alpha components of the text color.
--- @field SetTextColor fun(self: FontString, r: number, g: number, b: number, a?: number): nil # Sets the red, green, blue, and alpha components of the text color.
--- @field GetJustifyH fun(self: FontString): string # Gets the horizontal alignment of the text (e.g., "LEFT", "CENTER", "RIGHT").
--- @field GetStringHeight fun(self: FontString): number # Returns the height of the currently displayed text in the font string.




--- @class Texture
--- @field SetColorTexture fun(self: Texture, r: number, g: number, b: number, a: number): nil Sets the color and alpha of the texture.
--- @field GetVertexColor fun(self: Texture): number, number, number, number Gets the current color and alpha.
--- @field SetAllPoints fun(self: Texture, parent: Frame|nil): nil Sets the texture to fill the specified parent frame.
--- @field GetPoint fun(self: Texture, index: number): string, Region|nil, string|nil, number|nil, number|nil # Gets the anchor point at the specified index.



--- @class PlayerModel : Frame
--- @field SetCamDistanceScale fun(self: PlayerModel, scale: number): nil Sets the camera distance scale.
--- @field SetModelScale fun(self: PlayerModel, scale: number): nil Sets the scale of the model.
--- @field SetDisplayInfo fun(self: PlayerModel, displayId: number): nil Sets the model display info.
--- @field ClearModel fun(self: PlayerModel): nil # Clears the currently displayed model.
