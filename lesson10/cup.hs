-- 10.1

cup flOz = \message -> message flOz

getOz aCup = aCup (\prop -> prop)

drink aCup ozDrank = if ozDiff >= 0
                     then cup ozDiff
                     else cup 0
  where oldOz = getOz aCup
        ozDiff = oldOz - ozDrank

isEmpty aCup = getOz aCup == 0

-- 10.2

robot (name, attack, hp) = \msg -> msg (name, attack, hp)

name (n, _, _) = n
attack (_, a, _) = a
hp (_, _, hp) = hp

getName aRobot = aRobot name
getAttack aRobot = aRobot attack
getHP aRobot = aRobot hp

setName aRobot newName = aRobot (\(n, a, h) -> robot (newName, a, h))
setAttack aRobot newAttack = aRobot (\(n, a, h) -> robot (n, newAttack, h))
setHP aRobot newHP = aRobot (\(n, a, h) -> robot (n, a, newHP))

printRobot aRobot = aRobot (\(name, attack, hp) -> name ++
                                                   " attack: " ++ (show attack) ++
                                                   " hp: " ++ (show hp))

damage aRobot attackDamage = aRobot (\(n, a, h) -> robot (n, a, h - attackDamage))

fight aRobot defender = damage defender attack
  where attack = if getHP aRobot > 10
                 then getAttack aRobot
                 else 0
