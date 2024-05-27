parte_basica [] = []
parte_basica (x:xs) = x:parte_basica (filter (x/=) xs)

parte_basicaPara :: (a -> a -> Bool) -> [a] -> [a]
parte_basicaPara _ [] = []
parte_basicaPara p (x:xs) = x:parte_basicaPara p (filter (\y -> not (p x y)) xs)

parte_basica' l = parte_basicaPara (==) l

