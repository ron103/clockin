
// Views/Home/QuoteView.swift
import SwiftUI

let sampleQuotes: [String] = [
    "\"The only limit to our realization of tomorrow is our doubts of today.\" - Franklin D. Roosevelt",
    "\"Success is not final, failure is not fatal: It is the courage to continue that counts.\" - Winston Churchill",
    "\"Believe you can and you're halfway there.\" - Theodore Roosevelt",
    "\"It does not matter how slowly you go as long as you do not stop.\" - Confucius",
    "\"Hardships often prepare ordinary people for an extraordinary destiny.\" - C.S. Lewis",
    "\"Don't watch the clock; do what it does. Keep going.\" - Sam Levenson",
    "\"Everything you’ve ever wanted is on the other side of fear.\" - George Addair",
    "\"Opportunities don't happen. You create them.\" - Chris Grosser",
    "\"I am not a product of my circumstances. I am a product of my decisions.\" - Stephen Covey",
    "\"When everything seems to be going against you, remember that the airplane takes off against the wind, not with it.\" - Henry Ford",
    "\"The secret of getting ahead is getting started.\" - Mark Twain",
    "\"It's not whether you get knocked down, it's whether you get up.\" - Vince Lombardi",
    "\"Your time is limited, so don't waste it living someone else's life.\" - Steve Jobs",
    "\"Don't be afraid to give up the good to go for the great.\" - John D. Rockefeller",
    "\"I find that the harder I work, the more luck I seem to have.\" - Thomas Jefferson",
    "\"If you are not willing to risk the usual, you will have to settle for the ordinary.\" - Jim Rohn",
    "\"Success usually comes to those who are too busy to be looking for it.\" - Henry David Thoreau",
    "\"Don't be distracted by criticism. Remember—the only taste of success some people get is to take a bite out of you.\" - Zig Ziglar",
    "\"If you really look closely, most overnight successes took a long time.\" - Steve Jobs",
    "\"The only place where success comes before work is in the dictionary.\" - Vidal Sassoon",
    "\"The road to success and the road to failure are almost exactly the same.\" - Colin R. Davis",
    "\"Success is walking from failure to failure with no loss of enthusiasm.\" - Winston Churchill",
    "\"Just when the caterpillar thought the world was over, it became a butterfly.\" - Anonymous",
    "\"Don't limit your challenges. Challenge your limits.\" - Anonymous",
    "\"If you want to achieve greatness stop asking for permission.\" - Anonymous",
    "\"There are no secrets to success. It is the result of preparation, hard work, and learning from failure.\" - Colin Powell",
    "\"The only way to do great work is to love what you do.\" - Steve Jobs",
    "\"The best revenge is massive success.\" - Frank Sinatra",
    "\"Success is not the key to happiness. Happiness is the key to success.\" - Albert Schweitzer",
    "\"The only limit to our realization of tomorrow will be our doubts of today.\" - Franklin D. Roosevelt"
]

struct QuoteView: View {
    let quote: String
    var body: some View {
        Text(quote)
            .font(.footnote)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.bottom)
            
    }
}
