# $LUA
$LUA is a transpiller that is based entirely off lua meaning it can be intergrated in all your lua projects easily. It adds the "$" key shortcut which contains the
last created variable


```lua
x = 1
y = 2

x = $ + y -- 3

--or

tree = {
  root{
    root1={1}}
    
$ = $ + 1
