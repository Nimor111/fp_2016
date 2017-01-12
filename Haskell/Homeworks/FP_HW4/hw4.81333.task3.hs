type Vertex = Int
type Edge = (Vertex, Vertex)
type Graph = [Edge]

getSuccessors :: Graph -> Vertex -> [Vertex]
getSuccessors [] _ = []
getSuccessors (e:g) v
  | v == fst e = snd e : getSuccessors g v
  | otherwise = getSuccessors g v

allPaths :: Vertex -> Graph -> [[Vertex]]
allPaths v g = ways
    where
      vertexEdges = filter (\f -> fst f == v) g
      succs = getSuccessors g v
      ways = if null vertexEdges
             then [[v]]
             else map (\x -> v : x) $ concatMap (`allPaths` g) succs

isSumReachable :: Graph -> Vertex -> Int -> Bool
isSumReachable g v s =
  any (`findSumInList` s) (allPaths v g)

findSumInList :: [Int] -> Int -> Bool
findSumInList xs s = helper xs 0
  where
    helper (x:xs) sum
      | sum == s = True
      | null xs && (sum + x) == s = True
      | null xs && (sum + x) /= s = False
      | otherwise = helper xs (sum + x)

main = do
  print $ isSumReachable g 2 7
  print $ isSumReachable g 1 8
  print $ isSumReachable g 1 10
  print $ isSumReachable g 6 6
  print $ isSumReachable g 6 3
    where g = [(1,2), (1,3), (1,4), (2,5), (3,6), (4,5), (5,6)] 
