[
   Chunk                            -- V[_1 _2],
   Chunk.1:iter-star                -- _1,
   Chunk                            -- V[_1],
   Chunk.1:iter-star                -- _1,
   Assignment                       -- H hs=1[_1 KW["="] _2],
   Assignment.1:iter-sep            -- _1 KW[", "],
   Assignment.2:iter-sep            -- _1 KW[", "],
   DoWhile                          -- V is=2[KW["do"] _1] KW["end"],
   While                            -- V is=2[H hs=0[KW["while "] _1 KW[" do "]] _2] KW["end"],
   Repeat                           -- KW["repeat"] _1 KW["until"] _2,
   ElseIfPart                       -- V is=2[H[KW["elseif"] _1 KW["then"]] _2],
   If                               -- V is=2[H[KW["if"] _1 KW["then"]] _2] KW["end"],
   If                               -- V is=2[H[KW["if"] _1 KW["then"]] _2] V is=2[KW["else"] _3] KW["end"],
   IfElseIf                         -- V is=2[H[KW["if"] _1 KW["then"]] _2] _3 KW["end"],
   IfElseIf.3:iter                  -- _1,
   If                               -- V is=2[H[KW["if"] _1 KW["then"]] _2] _3 V is=2[KW["else"] _4] KW["end"],
   If.3:iter                        -- _1,
   ExpPart                          -- KW[","] _1,
   For                              -- KW["for"] _1 KW["="] _2 KW[","] _3 _4 KW["do"] _5 KW["end"],
   For.4:opt                        -- _1,
   ForIn                            -- V is=2[H hs=0[KW["for "] _1 KW[" in "] _2 KW[" do"]] _3] KW["end"],
   ForIn.1:iter-sep                 -- H hs=0[_1 KW[", "]],
   ForIn.2:iter-sep                 -- H hs=0[_1 KW[", "]],
   FuncDef                          -- V is=2[H[KW["function"] H hs=0[_1 KW["("] _2 KW[")"]]] _3] KW["end"],
   LocalFuncDef                     -- KW["local"] KW["function"] _1 KW["("] _2 KW[")"] _3 KW["end"],
   LocalVarDef                      -- V  [H  [KW["local"]] _1],
   LocalVarDef.1:iter-sep           -- _1 KW[","],
   LocalVarDef                      -- KW["local"] _1 KW["="] _2,
   LocalVarDef.1:iter-sep           -- _1 KW[","],
   LocalVarDef.2:iter-sep           -- _1 KW[","],
   Return                           -- KW["return"],
   Return                           -- V  [H  [KW["return"]] _1],
   Return.1:iter-sep                -- _1 KW[","],
   Break                            -- KW["break"],
   DotIdPart                        -- KW["."] _1,
   FunctionName                     -- _1,
   FunctionName                     -- H hs=0[_1 KW[":"] _2],
   FunctionName                     -- _1 _2,
   FunctionName.2:iter              -- _1,
   FunctionName                     -- H hs=0[_1 _2 KW[":"] _3],
   FunctionName.2:iter              -- _1,
   Call                             -- H hs=0[_1 _2],
   Call                             -- H hs=0[_1 KW[":"] _2 _3],
   Args                             -- H hs=0[KW["("] _1 KW[")"]],
   Args.1:iter-star-sep             -- _1 KW[", "],
   VarRef                           -- VAR[_1],
   TableVarRef                      -- H hs=0[_1 KW["["] _2 KW["]"]],
   Access                           -- H hs=0[_1 KW["."] _2],
   Field                            -- H hs=0[KW["["] _1 KW["]"] KW[" = "] _2],
   Field                            -- H hs=0[_1 KW[" = "] _2],
   Field                            -- H hs=0[_1],
   Table                            -- H hs=0[KW["{"] KW["}"]],
   Table                            -- H hs=0[KW["{"] _1 KW["}"]],
   Table                            -- H hs=0[KW["{"] _1 KW["}"]],
   Table.1:iter-sep                 -- H hs=0[_1 KW[", "]],
   Table                            -- H hs=0[KW["{"] _1 KW["}"]],
   Table.1:iter-sep                 -- H hs=0[_1 KW["; "]],
   LuaNil                           -- KW["nil"],
   False                            -- KW["false"],
   True                             -- KW["true"],
   Number                           -- NUM[_1],
   Number                           -- NUM[_1],
   String                           -- H hs=0[KW["\""] _1 KW["\""]],
   Nothing                          -- KW["..."],
   Function                         -- KW["function"] KW["("] _1 KW[")"] _2 KW["end"],
   Not                              -- KW["not"] _1,
   Umin                             -- KW["-"] _1,
   Hash                             -- KW["#"] _1,
   Add                              -- H hs=1[_1 KW["+"] _2],
   Sub                              -- H hs=1[_1 KW["-"] _2],
   Mul                              -- H hs=1[_1 KW["*"] _2],
   Div                              -- H hs=1[_1 KW["/"] _2],
   Mod                              -- H hs=1[_1 KW["%"] _2],
   Pow                              -- H hs=1[_1 KW["^"] _2],
   Concat                           -- H hs=1[_1 KW[".."] _2],
   Eq                               -- H hs=1[_1 KW["=="] _2],
   Neq                              -- H hs=1[_1 KW["~="] _2],
   Lt                               -- H hs=1[_1 KW["<"] _2],
   Lte                              -- H hs=1[_1 KW["<="] _2],
   Gt                               -- H hs=1[_1 KW[">"] _2],
   Gte                              -- H hs=1[_1 KW[">="] _2],
   And                              -- H hs=1[_1 KW["and"] _2],
   Or                               -- H hs=1[_1 KW["or"] _2],
   VaradicParList                   -- KW["..."],
   PartialVaradicParList            -- _1 KW[","] KW["..."],
   PartialVaradicParList.1:iter-sep -- _1 KW[","],
   ParList                          -- _1,
   ParList.1:iter-sep               -- _1 KW[","],
   ParList                          -- 
]