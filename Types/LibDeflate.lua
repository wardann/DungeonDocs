---@class LibDeflate
---@field EncodeForPrint fun(self: LibDeflate, data: string): string # Encodes data into a Base64-like format for printing
---@field DecodeForPrint fun(self: LibDeflate, encodedData: string): string|nil, string|nil # Decodes data from a Base64-like printable format
---@field CompressDeflate fun(self: LibDeflate, data: string): string # Compresses data using the Deflate algorithm
---@field DecompressDeflate fun(self: LibDeflate, compressedData: string): string|nil, string|nil # Decompresses Deflate-compressed data
