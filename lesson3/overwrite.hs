overwrite x = let x = 2
              in
               let x = 3
               in
                let x = 4
                in
                 x

overwrite2 x = let x = 2
               in
                let x = 3
                in
                 let xy = 4
                 in
                  xy

overwriteLambda x = (\x -> (\x -> (\x -> x) 4) 3) 2
