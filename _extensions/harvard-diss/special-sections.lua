local function in_table(tbl, value)
    if tbl == nil then
        return false
    end
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function Pandoc(doc)
    for i, el in pairs(doc.blocks) do
        if (in_table(el.classes, "introduction")) then
            table.insert(doc.blocks, i, pandoc.RawInline("typst", "#counter(heading).update(0)\n"))
            break
        end
    end
    for i, el in pairs(doc.blocks) do
        if (in_table(el.classes, "appendix")) then
            table.insert(doc.blocks, i, pandoc.RawInline("typst", "#show: appendix\n"))
            break
        end
    end
    return pandoc.Pandoc(doc.blocks, doc.meta)
end
