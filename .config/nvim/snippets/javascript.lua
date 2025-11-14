local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to get current function/class name using treesitter
local function get_enclosing_name()
  local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
  if not ok then
    return "NO_TS"
  end

  local node = ts_utils.get_node_at_cursor()
  if not node then
    return "NO_NODE"
  end

  -- Debug: collect node types while walking up
  local debug_types = {}
  local current = node

  -- Walk up the tree to find function/class/method declaration
  while current do
    local node_type = current:type()
    table.insert(debug_types, node_type)

    -- Class declaration
    if node_type == "class_declaration" then
      for i = 0, current:child_count() - 1 do
        local child = current:child(i)
        if child and child:type() == "identifier" then
          return vim.treesitter.get_node_text(child, 0)
        end
      end
    end

    -- Function declaration
    if node_type == "function_declaration" then
      for i = 0, current:child_count() - 1 do
        local child = current:child(i)
        if child and child:type() == "identifier" then
          return vim.treesitter.get_node_text(child, 0)
        end
      end
    end

    -- Method definition
    if node_type == "method_definition" then
      for i = 0, current:child_count() - 1 do
        local child = current:child(i)
        if child and child:type() == "property_identifier" then
          return vim.treesitter.get_node_text(child, 0)
        end
      end
    end

    -- Object method/property (pair in object)
    if node_type == "pair" then
      local key_node = current:child(0)
      if key_node then
        return vim.treesitter.get_node_text(key_node, 0)
      end
    end

    -- Variable declarator (const foo = () => {})
    if node_type == "variable_declarator" or node_type == "lexical_declaration" then
      for i = 0, current:child_count() - 1 do
        local child = current:child(i)
        if child and child:type() == "variable_declarator" then
          local name_node = child:child(0)
          if name_node and name_node:type() == "identifier" then
            return vim.treesitter.get_node_text(name_node, 0)
          end
        end
        if child and child:type() == "identifier" then
          -- Check if next sibling is arrow_function or function
          for j = i + 1, current:child_count() - 1 do
            local val = current:child(j)
            if val and (val:type() == "arrow_function" or val:type() == "function" or val:type() == "function_expression") then
              return vim.treesitter.get_node_text(child, 0)
            end
          end
        end
      end
    end

    -- Arrow function in export
    if node_type == "export_statement" then
      for i = 0, current:child_count() - 1 do
        local child = current:child(i)
        if child and child:type() == "lexical_declaration" then
          for j = 0, child:child_count() - 1 do
            local declarator = child:child(j)
            if declarator and declarator:type() == "variable_declarator" then
              local name_node = declarator:child(0)
              if name_node and name_node:type() == "identifier" then
                return vim.treesitter.get_node_text(name_node, 0)
              end
            end
          end
        end
      end
    end

    current = current:parent()
  end

  -- If we found no function, show first few node types for debugging
  return "FILE[" .. table.concat(debug_types, ",", 1, math.min(3, #debug_types)) .. "]"
end

return {
  -- Unicorn console.log snippet
  s("ulog", {
    t('console.log("🦄 === ['),
    f(get_enclosing_name, {}),
    t('] '),
    i(1, "message"),
    t('")'),
  }),
}
