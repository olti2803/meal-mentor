import SwiftUI

struct SimpleCalendarView: View {
    @Binding var selectedDate: Date
    let calendar = Calendar.current

    // This function creates an array of dates for the month of the given date.
    func monthDates(for date: Date) -> [Date?] {
        var dates = [Date?]()
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstOfMonth = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: firstOfMonth)!
        
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let weekdayOffset = firstWeekday - calendar.firstWeekday
        
        for _ in 0..<weekdayOffset {
            dates.append(nil) // fill in empty days at the start of the calendar grid
        }
        
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    var body: some View {
        VStack {
            // Month and year header
            Text(monthYearFormatter.string(from: selectedDate))
                .font(.title)
                .padding(10)
            
            // Days of the week header
            HStack {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                        .frame(maxWidth: .infinity)
                
                }
            }
            
            // Dates grid for the month
            let dates = monthDates(for: selectedDate)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(dates.indices, id: \.self) { index in
                    if let date = dates[index] {
                        Text("\(calendar.component(.day, from: date))")
                            .padding(10)
                            .background(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.blue : Color.clear)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.selectedDate = date
                            }
                    } else {
                        Text(" ")
                            .padding(10)
                    }
                }
            }
        }
    }
    
    // DateFormatter to display the month and year on the header
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

struct SimpleCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCalendarView(selectedDate: .constant(Date()))
    }
}
