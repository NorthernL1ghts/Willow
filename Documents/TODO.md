# Willow TODO:

- [x] Lex source into tokens or something.

- [ ] Parse tokens or something into AST -- Just a tree containing data about the program.

- [ ] Compiler AST into assembly, let's start with x86_64? We could also transpile into another language that then gets compiled, like C or something.

# Miscellaneous

- Unnamed variables
    - It would be cool if an assignment and/or variable declaration could have no identifier, and work on a singular unnamed variable in the environment. Not entirely sure how this would work yet semantically within our symbol table.