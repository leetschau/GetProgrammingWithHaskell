# 用 package.yaml 代替 cabal 定义文件

由于现在的 stack 版本使用 package.yaml 生成项目的 cabal 文件
（这里是 palindrome-checker.cabal），且 cabal 文件被放在 .gitignore 中，
所以书中在 cabal 文件中添加的内容都要改为定义在 package.yaml 中，包括如下内容：

* `name`, `version`, `author`, `maintainer`, `description`  等内容更新到此文件中；

* 在 `library` 和 `executables` 中添加 `default-extensions: OverloadedStrings`;

* 在 `dependencies` 中添加 `text`;

更新 package.yaml 后，再次执行 `stack build` 前，需要手工删除 palindrome-checker.cabal 文件。
