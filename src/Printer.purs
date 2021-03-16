module Printer where

import Ansi.Codes (Color(..))
import Ansi.Output (foreground, withGraphics)
import Data.Functor (void)
import Data.Stac (Collection(..), CollectionsResponse(..), ConformanceClasses)
import Data.Traversable (traverse)
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Prelude (Unit, discard, ($), (<<<), (<>))

prettyPrintCollections :: forall m. MonadEffect m => CollectionsResponse -> m Unit
prettyPrintCollections (CollectionsResponse { collections }) =
  let
    collectionLine (Collection collection) = withGraphics (foreground Blue) (collection.id <> ": ") <> collection.description <> "\n"
  in
    void $ traverse (log <<< collectionLine) collections

prettyPrintConformance :: forall m. MonadEffect m => ConformanceClasses -> m Unit
prettyPrintConformance { conformsTo } = do
  log $ withGraphics (foreground Blue) "Conforms to:\n"
  void $ traverse log conformsTo