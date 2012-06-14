import System.Environment(withArgs,getArgs)
import Data.List(intercalate)

solve' 0 _ _ _ = []
solve' n a b c = (solve' (n-1) a c b) ++ (a,c) : (solve' (n-1) b a c)
solution n = intercalate "\n" . map (trans) $ solve' n "A" "B" "C"
    where trans (a,b) = a ++ " -> " ++ b

main = getArgs >>= putStrLn . solution . read . head . (++["7"])
