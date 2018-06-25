import Data.List

main = do
  print (show (ifEven (\x -> x ^ 3) 4))
  print (show (sortBy compareLastNames2 names2))
  print (show (sortBy compareLastNames3 names2))
  print (addressLetter ("Chad", "Lee") "dc")


-- GC 4.1

ifEven myFunc n = if even n
                  then myFunc n
                  else n

-- GC 4.2

names = [("Ian", "Curtis"),
         ("Bernard","Sumner"),
         ("Peter", "Hook"),
         ("Stephen","Morris")]


compareLastNames name1 name2 = if lastname1 > lastname2
                               then GT
                               else if lastname1 < lastname2
                                    then LT
                                    else EQ
  where lastname1 = snd name1
        lastname2 = snd name2

names2 = [("Ian", "Curtis"),
          ("Bernard","Sumner"),
          ("Peter", "Hook"),
          ("Stephen","Morris"),
          ("Cauder", "Hook")]

compareLastNames2 name1 name2 = if lastname1 > lastname2
                                then GT
                                else if lastname1 < lastname2
                                     then LT
                                     else if firstname1 > firstname2
                                          then GT
                                          else if firstname1 < firstname2
                                               then LT
                                               else EQ
  where lastname1 = snd name1
        lastname2 = snd name2
        firstname1 = fst name1
        firstname2 = fst name2

-- Q4.1

compareLastNames3 name1 name2 = if compThem /= EQ
                                then compThem
                                else compare firstname1 firstname2
  where lastname1 = snd name1
        lastname2 = snd name2
        firstname1 = fst name1
        firstname2 = fst name2
        compThem = compare lastname1 lastname2

-- Q4.2

sfOffice name = if lastName < "L"
  then nameText ++ " - PO Box 1234 - San Francisco, CA, 94111"
  else nameText ++ " - PO Box 1010 - San Francisco, CA, 94109"
  where lastName = snd name
        nameText = (fst name) ++ " " ++ lastName

nyOffice name = nameText ++ ": PO Box 789 - New York, NY, 10013"
  where nameText = (fst name) ++ " " ++ (snd name)

renoOffice name = nameText ++ " - PO Box 456 - Reno, NV 89523"
  where nameText = snd name

dcOffice name = nameText ++ ": PO Box 708 - Washington, DC, 10031"
  where nameText = (fst name) ++ " " ++ (snd name) ++ ", Esq"

getLocationFunction location = case location of
  "ny" -> nyOffice
  "sf" -> sfOffice
  "reno" -> renoOffice
  "dc" -> dcOffice
  _ -> (\name -> (fst name) ++ " " ++ (snd name))

addressLetter name location = locationFunction name
  where locationFunction = getLocationFunction location
