module Operator 
    ( (|>)
    ) where


(|>) :: a -> (a -> b) -> b
x |> f = f x
infixl 1 |>