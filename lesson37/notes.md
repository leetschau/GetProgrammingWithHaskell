* Listing 37.3 on page 469:
  package.yaml 不需要手工修改 `exposed-modules` 的值。

* Listing 37.7 on page 472:
  `n >= length primes` 这个判断标准是错的，应该是 `n >= upperBound`。

stack 常用命令：

* stack new <project-name>

* stack setup

* stack build

* stack exec

* stack run: 相当于 build + exec

* stack test