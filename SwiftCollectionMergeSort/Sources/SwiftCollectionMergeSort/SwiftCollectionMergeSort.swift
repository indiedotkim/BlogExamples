/// In-place merge sort for mutable random-access collections.
///
/// An in-place merge sort implementation that uses the "common" approach of
/// using a scratch space (or, buffer) to carry out re-ordering.
///
/// This is different from another approach that is sometimes being taught:
/// splitting and then concatenating arrays together as the recursion unwinds.
/// However, array concatenation is only O(1) on average and O(n) in the worst
/// case. Since merge sort literally requires merging a lot, this is a worse
/// solution.
///
/// Further reading: [Merge Sort (Wikipedia)](https://en.wikipedia.org/wiki/Merge_sort)
///
/// - Parameters:
///   - array: A mutable random-access collection that will be sorted in-place.
public func sort<T: MutableCollection &
                    RandomAccessCollection>(array source: inout T) where T.Element: Comparable,
                                                                         T.Index: Strideable,
                                                                         T.Index.Stride: SignedInteger {
    // Creates a copy of `source`, which is then used as the new input for the
    // split/merge. `source` can then be used as the output; it becomes the
    // output for the sorted collection.
    var scratch: T = Array(source) as! T
    splitThenMerge(from: &scratch, to: &source, start: source.startIndex, end: source.endIndex)
}

/// Splits the `source` collection into two halves, recurses to split those
/// halves until they cannot be split any further (collection `count <= 1`),
/// and thn proceeds to merge the smaller fragments together by re-ordering
/// their contents.
public func splitThenMerge<T: MutableCollection>(from source: inout T,
                                                   to destination: inout T,
                                                   start: T.Index,
                                                   end: T.Index) where T.Element: Comparable,
                                                                       T.Index: Strideable,
                                                                       T.Index.Stride: SignedInteger {
    // A collection fragment of size 0 or 1 is sorted by default, because
    // there is just one value within that fragment.
    if start.distance(to: end).magnitude <= 1 { return }
    // Calculating the middle: start + (end - start) / 2
    let relativeMiddle = Int(end.distance(to: start).magnitude) / 2
    let absoluteMiddle = start.advanced(by: T.Index.Stride(exactly: relativeMiddle)!)
    splitThenMerge(from: &destination, to: &source, start: start, end: absoluteMiddle)
    splitThenMerge(from: &destination, to: &source, start: absoluteMiddle, end: end)
    merge(from: &source, to: &destination, start: start, middle: absoluteMiddle, end: end)
}

/// Merges two sorted fragments. The first fragment is being read from
/// `start..<middle` and the second fragment is read from `middle..<end`
/// (in pseudo notation, since indexes cannot be written like that).
public func merge<T: MutableCollection>(from source: inout T,
                                          to destination: inout T,
                                          start: T.Index,
                                          middle: T.Index,
                                          end: T.Index) where T.Element: Comparable,
                                                              T.Index: Strideable,
                                                              T.Index.Stride: SignedInteger {
    var (leftIndex, rightIndex) = (start, middle)
    for writeIndex in start..<end {
        if leftIndex < middle
            && (rightIndex >= end || source[leftIndex] < source[rightIndex]) {
            destination[writeIndex] = source[leftIndex]
            leftIndex = leftIndex.advanced(by: 1)
        } else {
            destination[writeIndex] = source[rightIndex]
            rightIndex = rightIndex.advanced(by: 1)
        }
    }
}
