#include<iostream>
using namespace std;

typedef long long int ll;
typedef pair<ll,ll> pii;
#define REP(i,n) for(ll i=0;i<n;i++)

#ifdef DEBUG
#define dbg(x) x
#define dbgp(x) cerr << x << endl;
#else
#define dbg(x) //x
#define dbgp(x) //cerr << x << endl;
#endif

int solve() {
    int n, b;
    cin >> n >> b;

    int xs[n];
    REP(i, n) {
        cin >> xs[i];
    }

    sort(xs, xs+n);

    int count = 0;
    int ba = 0;
    REP(i, n) {
        if (ba + xs[i] > b) {
            break;
        }
        count++;
        ba += xs[i];
    }
    return count;
}

int main(){
    int t;
    cin >> t;
    REP(i, t) {
        cout << "Case #" << (i+1) << ": ";
        cout << solve() << endl;
    }
}

/**
        (answer, _) = foldl' folder (0,0) sorted 
        sorted = sort xs
        folder :: (IInt, IInt) -> IInt -> (IInt, IInt)
        folder (count, total) x
            | total + x > b = (count, total+x) 
            | otherwise = (count+1, total+x)
            */
