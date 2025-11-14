local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to get current function/class name using treesitter
local function get_enclosing_name()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()

  if not node then
    return "UNKNOWN"
  end

  while node do
    local node_type = node:type()

    if node_type == "function_declaration"
       or node_type == "function_expression"
       or node_type == "arrow_function"
       or node_type == "method_definition"
       or node_type == "class_declaration"
       or node_type == "lexical_declaration" then

      local name_node = node:field("name")[1]
      if name_node then
        return vim.treesitter.get_node_text(name_node, 0)
      end

      if node_type == "lexical_declaration" then
        local declarator = node:field("declarator")[1]
        if declarator then
          local var_name = declarator:field("name")[1]
          if var_name then
            return vim.treesitter.get_node_text(var_name, 0)
          end
        end
      end
    end

    node = node:parent()
  end

  return "GLOBAL"
end

return {
  s("ulog", {
    t('console.log("🦄 === ['),
    f(get_enclosing_name, {}),
    t('] '),
    i(1, "message"),
    t('")'),
  }),
}
