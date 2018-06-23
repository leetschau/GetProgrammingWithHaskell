counter x = (\x -> x + 1)
            ((\x -> x + 1)
             ((\x -> x) x))

counter2 x = (\m -> m + 1)
             ((\n -> n + 1)
              ((\p -> p) x))
