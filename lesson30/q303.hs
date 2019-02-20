bind :: Maybe a -> (a -> Maybe b) -> Maybe b
bind (Just x) func = func x
bind Nothing func = Nothing
