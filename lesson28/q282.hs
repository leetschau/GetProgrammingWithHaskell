main :: IO ()
main = do
  putStrLn "Enter the positions:"
  putStrLn "for example: (1.2, 3,4)"
  dist <- haversineIO readLatLong readLatLong
  print dist

type LatLong = (Double, Double)

toRadians :: Double -> Double
toRadians degrees = degrees * pi / 180

latLongToRads :: LatLong -> (Double, Double)
latLongToRads (lat, long) = (rlat, rlong)
  where rlat = toRadians lat
        rlong = toRadians long

haversine :: LatLong -> LatLong -> Double
haversine coords1 coords2 = earthRadius * c
  where (rlat1, rlong1) = latLongToRads coords1
        (rlat2, rlong2) = latLongToRads coords2
        dlat = rlat2 - rlat1
        dlong = rlong2 - rlong1
        a = (sin (dlat / 2)) ^ 2 + cos rlat1 * cos rlat2 * (sin (dlong / 2)) ^ 2
        c = 2 * atan2 (sqrt a) (sqrt (1 - a))
        earthRadius = 3961.0

readLatLong :: IO LatLong
readLatLong = read <$> getLine

haversineIO :: IO LatLong -> IO LatLong -> IO Double
haversineIO p1 p2 = haversine <$> p1 <*> p2
