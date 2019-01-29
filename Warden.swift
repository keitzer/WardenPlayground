import UIKit

// Implemented the following using NO CACHE (aka: re-calculates every time you call it)
// If you wanted a Cache, simply run every possible # from 1 to N, where N is the number of cells
// Then store the values in a 2-D Array. Eg: Row 0 is initial state. Row 1 is after 1st run. Etc

enum CellState {
    case open
    case closed

    mutating func flip() {
        self = self == .open ? .closed : .open
    }
}

class Warden {
    private var cellCount: Int
    private var startingCellNumber: Int

    init(cells count: Int, startingCellNumber: Int = 1) {
        cellCount = count
        self.startingCellNumber = startingCellNumber
    }

    // CALCULATE METHOD #1:
    // RE-CALCULATE EVERY CELL FOR EVERY CYCLE:

//    func state(of cellNumber: Int, afterMoreCycles numberOfCycles: Int) -> CellState {
//        let index = cellNumber - startingCellNumber
//        var cells: [CellState] = Array(repeating: .closed, count: cellCount)
//        if numberOfCycles == 0 {
//            return cells[index]
//        }
//
//        for cycleIndex in 1...numberOfCycles {
//            cells = cycle(with: cells, at: cycleIndex)
//        }
//        return cells[index]
//    }
//
//    private func cycle(with cells: [CellState], at cycleIndex: Int) -> [CellState] {
//        var cells = cells
//
//        for index in 0..<cells.count {
//            if (index + startingCellNumber) % cycleIndex == 0 {
//                cells[index].flip()
//            }
//        }
//        return cells
//    }


    // CALCULATE METHOD #2:
    // CALCULATE ONLY FOR THAT CELL (MUCH MORE EFFICIENT THAN #1):
    // Note that this method DOES NOT care how many cells there are total. So technically there could be a fake "bounds check" if needed

    func state(of cellNumber: Int, afterMoreCycles numberOfCycles: Int) -> CellState {
        if numberOfCycles == 0 {
            return .closed
        }

        var state = CellState.closed

        for cycleIndex in 1...numberOfCycles {
            if cellNumber % cycleIndex == 0 {
                state.flip()
            }
        }

        return state
    }
}

let subject = Warden(cells: 100)

// A demonstration of how it works / "testing" without unit tests, because it's a Playground file:

subject.state(of: 1, afterMoreCycles: 0)
subject.state(of: 2, afterMoreCycles: 0)
subject.state(of: 3, afterMoreCycles: 0)
subject.state(of: 4, afterMoreCycles: 0)

subject.state(of: 1, afterMoreCycles: 1)
subject.state(of: 2, afterMoreCycles: 1)
subject.state(of: 3, afterMoreCycles: 1)
subject.state(of: 4, afterMoreCycles: 1)

subject.state(of: 1, afterMoreCycles: 2)
subject.state(of: 2, afterMoreCycles: 2)
subject.state(of: 3, afterMoreCycles: 2)
subject.state(of: 4, afterMoreCycles: 2)

subject.state(of: 1, afterMoreCycles: 3)
subject.state(of: 2, afterMoreCycles: 3)
subject.state(of: 3, afterMoreCycles: 3)
subject.state(of: 4, afterMoreCycles: 3)

subject.state(of: 1, afterMoreCycles: 4)
subject.state(of: 2, afterMoreCycles: 4)
subject.state(of: 3, afterMoreCycles: 4)
subject.state(of: 4, afterMoreCycles: 4)


// Finally answering the Kata question: "How many cells are open after 100 iterations"?

let totalCells = 100
var openCells = 0
for cell in 1...totalCells where subject.state(of: cell, afterMoreCycles: totalCells) == .open {
    openCells += 1
}
print(openCells)
