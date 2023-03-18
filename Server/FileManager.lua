ServerFunctions = {};
ServerFunctions.FileManager = {};

local FILE_MEMORY = {};

function ServerFunctions.FileManager.DoesFileExist(Resource, Path)
    local TargetFile;

    if(FILE_MEMORY[Path] ~= nil) then
        TargetFile = FILE_MEMORY[Path];
    else
        TargetFile = LoadResourceFile(Resource, Path);
        FILE_MEMORY[Path] = TargetFile;
    end

    if(TargetFile == nil or TargetFile == "nil") then
        return false;
    else
        return true;
    end
end

function ServerFunctions.FileManager.SaveFile(Resource, Path, Content)
    SaveResourceFile(Resource, Path, json.encode(Content), -1);

    FILE_MEMORY[Path] = Content;
end

function ServerFunctions.FileManager.LoadFile(Resource, Path)
    local TargetFile;

    if(FILE_MEMORY[Path] ~= nil) then
        TargetFile = FILE_MEMORY[Path];
    else
        TargetFile = LoadResourceFile(Resource, Path);
        FILE_MEMORY[Path] = TargetFile;
    end

    if(type(TargetFile) == "string") then
        TargetFile = json.decode(TargetFile);
    end

    return TargetFile;
end