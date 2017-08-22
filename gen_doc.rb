#!/usr/bin/ruby

require 'json'

`sourcekitten doc --module-name Extensions -- -project Extensions.xcodeproj > comment.json`

commentJson = JSON.parse(File.read('comment.json'))
formattedJson = commentJson.map { |dict| 
    key = dict.keys.first.split("\/").last.split(".").first
    if key.include?("Extensions")
        key = key.chomp("Extensions") + " " + "Extensions"

        subStructures = dict.values.first["key.substructure"].last["key.substructure"]
        subStructures = subStructures.map { |dict|
            # desc = dict["key.doc.name"] + "|" + dict["key.doc.comment"].split("\n\n").first
            # dict["key.doc.name"]
            newDict = Hash.new
            funcName = dict["key.doc.name"]
            funcDesc = ""

            if dict["key.doc.comment"] != nil 
                funcDesc = dict["key.doc.comment"].split("\n\n").first
            end

            newDict[funcName] = funcDesc
            newDict
        }
        newDict = Hash.new
        newDict[key] = subStructures
        newDict
    end
}

formattedJson = formattedJson.compact

mdContent = formattedJson.reduce("# Extension List \n") { |memo, dict|
    title = "## " + dict.keys.first + "\n"
    subTitle = "| Function | Description |" + "\n"
    sep = "| :--- | :--- |" + "\n"

    funcArray = dict.values.first
    funcArrayContent = funcArray.reduce("") { |memo, dict|
        content = memo
        if dict.keys != nil
            funcName = dict.keys.first
            funcDesc = dict.values.first
    
            
            if funcName != nil && funcDesc != nil
                content += ("|" + funcName + "|" + funcDesc + "|" + "\n")
            end
        end

        content
    }

    memo + title + subTitle + sep + funcArrayContent
}

File.delete("comment.json")
File.delete("document.md")
File.write("document.md", mdContent)

