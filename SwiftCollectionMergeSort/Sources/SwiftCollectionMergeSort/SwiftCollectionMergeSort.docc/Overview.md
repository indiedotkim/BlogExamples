# ``SwiftCollectionMergeSort``

Example code of a merge sort implementation. Sorts a mutable random-access
collection in-place, which guarantees O(n log(n)) worst-case time complexity.

This package provides a reference implementation of an in-place merge sort
algorithm that works with Swift collections. More information about this
implementation can be found in the blog-post:
[Swift: Implementing a Generic Merge Sort](https://indie.kim/post/1-swift-collection-merge-sort).

**Note:** In a normal package, only ``sort(array:)`` would be part of the
public API. Here, the internal functions ``splitThenMerge(from:to:start:end:)``
and ``merge(from:to:start:middle:end:)`` are declared public too in order to
have documentation generated for them.

## Topics

### API

- ``sort(array:)``

### Internal

- ``splitThenMerge(from:to:start:end:)``
- ``merge(from:to:start:middle:end:)``
