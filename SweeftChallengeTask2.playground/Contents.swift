import Cocoa

// MARK: - Task 1
//Მოცემულია String ტიპის ცვლადი “s”. იპოვეთ ყველაზე გრძელი ისეთი substring-ის ზომა,
//რომელშიც ყველა სიმბოლო უნიკალურია(არ მეორდება).
//func lengthOfLongestSubstring(_ s: String) -> Int {
//// Implementation
//}
//Მაგალითი 1:
//Input: "abcabcbb"
//Output: 3
//Მაგალითი 2:
//Input: "bbbbb"
//Output: 1

func lengthOfLongestSubstring(_ s: String) -> Int {
    var result = 0
    var charSet = Set<Character>()
    var firstIndex = 0
    var secondIndex = 0
    
    while secondIndex < s.count {
        if charSet.contains(s[s.index(s.startIndex, offsetBy: secondIndex)]) == false {
            charSet.insert(s[s.index(s.startIndex, offsetBy: secondIndex)])
            secondIndex += 1
            result = max(result, charSet.count)
        } else {
            charSet.remove(s[s.index(s.startIndex, offsetBy: firstIndex)])
            firstIndex += 1
        }
    }
    return result
}

lengthOfLongestSubstring("abcabcbb")
lengthOfLongestSubstring("bbbbb")

// MARK: - Task 2
//Მოცემულია ორი String ცვლადი “s” და “t” დააბრუნეთ მინიმალური ფანჯარა(უწყვეტი
//საბსტრინგი) “s”-დან რომელიც შეიცავს “t”-ში შემავალ ყველა სიმბოლოს. თუ “s”-ში არ არის
//ისეთი ფანჯარა, რომელიც მოიცავს “t”-ის ყველა სიმბოლოს, დააბრუნეთ ცარიელი
//სტრინგი("").
//func minWindow(_ s: String, _ t: String) -> String {
//// Implementation
//}
//Მაგალითი 1:
//Input: s = "ADOBECODEBANC", t = "ABC"
//Output: "BANC"
//Მაგალითი 2:
//Input: s = "a", t = "aa"
//Output: ""

func minWindow(_ s: String, _ t: String) -> String {
    var map = [Character: Int]()
    for char in t {
        if let count = map[char] {
            map[char] = count + 1
        } else {
            map[char] = 1
        }
    }
    var firstChar = 0
    var secondChar = 0
    var length = Int.max
    var count = map.count
    var result = ""
    
    while secondChar < s.count {
        let rightChar = s[s.index(s.startIndex, offsetBy: secondChar)]
        if let rCount = map[rightChar] {
            map[rightChar] = rCount - 1
            if map[rightChar] == 0 {
                count -= 1
            }
        }
        secondChar += 1
        
        while count == 0 {
            if secondChar - firstChar < length {
                length = secondChar - firstChar
                result = String(s[s.index(s.startIndex, offsetBy: firstChar)..<s.index(s.startIndex, offsetBy: secondChar)])
            }
            let leftChar = s[s.index(s.startIndex, offsetBy: firstChar)]
            if let lCount = map[leftChar] {
                map[leftChar] = lCount + 1
                if map[leftChar]! > 0 {
                    count += 1
                }
            }
            firstChar += 1
        }
    }
    return result
}

minWindow("ADOBECODEBANC", "ABC")
minWindow("a", "aa")

// MARK: - Task 3
//Მოცემულია String “s” და String-ების მასივი “words”. დააბრუნეთ “true” თუ შეიძლება
//“s”-ის დაყოფა “-”-ით დაშორებული სიტყვების მიმდევრობად “words”-დან.
//func wordBreak(_ s: String, _ words: [String]) -> Bool {
//// Implementation
//}
//Მაგალითი 1:
//
//Input: s = "leetcode", words = ["leet", "code"]
//Output: true
//Მაგალითი 2:
//Input: s = "applepenapple", words = ["apple", "pen"]
//Output: true

func wordBreak(_ s: String, _ words: [String]) -> Bool {
    var newString = s
    var count = 0
    
    for word in words {
        if newString.contains(word) {
            newString = newString.replacingOccurrences(of: word, with: "-")
            count += 1
        }
    }
    if count == words.count {
        return true
    }
    return false
}

wordBreak("leetcode", ["leet", "code"])
wordBreak("applepenapple", ["apple", "pen"])

// MARK: - Task 4
//Მოცემულია მთელი რიცხვების მასივი “nums” და მთელი რიცხვი “k”. დააბრუნეთ
//დააბრუნეთ ყველაზე ხშირად გამეორებული “k” ცალი ელემენტი. Პასუხი შეგგიძლიათ
//დააბრუნოთ ნებისმიერი თანმიმდევრობით.
//func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
//// Implementation
//}
//Მაგალითი 1:
//Input: nums = [1,1,1,2,2,3], k = 2
//Output: [1,2]
//Მაგალითი 2:
//Input: nums = [1], k = 1
//Output: [1]

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var result = [Int]()
    var counts: [Int: Int] = [:]
    
    for num in nums {
        counts[num] = nums.filter({$0 == num}).count
    }
    
    for _ in 0...k-1 {
        let x = counts.max(by: {$0.value < $1.value})
        result.append(x!.key)
        counts.removeValue(forKey: x!.key)
    }
    return result
}

topKFrequent([1,1,1,2,2,3], 2)
topKFrequent([1], 1)

// MARK: - Task 5
//Მოცემულია შეხვედრების დროით ინტერვალების ორგანზომილებიანი მასივების მასივი
//“intervals”, სადაც “intervals[i] = [start_i, end_i]”. დააბრუნეთ მინიმუმ რამდენი ოთახია
//საჭირო ყველა შეხვედრის ჩასატარებლად(ისეთი შეხვედრები რომელთა ჩატარების
//დროებში თანაკვეთაა ერთ ოთახში ვერ ჩატარდება).
//func minMeetingRooms(_ intervals: [[Int]]) -> Int {
//// Implementation
//}
//Მაგალითი 1:
//Input: [[0, 30],[5, 10],[15, 20]]
//Output: 2
//Მაგალითი 2:
//Input: [[7,10],[2,4]]
//Output: 1

func minMeetingRooms(_ intervals: [[Int]]) -> Int {
    var result = 0
    let startArray = intervals.map({ $0[0] }).sorted()
    let endArray = intervals.map({ $0[1] }).sorted()
    var endIndex = 0
    
    for i in 0..<intervals.count {
        if startArray[i] < endArray[endIndex] {
            result += 1
        } else {
            endIndex += 1
        }
    }
    return result
}

minMeetingRooms([[0, 30],[5, 10],[15, 20]])
minMeetingRooms([[7,10],[2,4]])
