capital_final :: Double -> Double -> Int -> Double
capital_final c i 0 = c
capital_final c i a = capital_final (c * (1 + (i/100))) i (a - 1)

capital_final_test c i n = c* (1+i/100) ^ n

interes_total :: Double -> Double -> Int -> Double
interes_total c i a = ((capital_final c i a)/ c - 1) * 100

capital_final' :: Double -> Int -> Double -> Double -> Double
capital_final' c 0 i n = c
capital_final' c a i n = capital_final' (c * (1 + (i/100)) + n) (a - 1) i n
