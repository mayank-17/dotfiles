#include <bits/stdc++.h>
using namespace std;

// Fast I/O
#define fast_io ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

// Common macros
#define ll long long
#define ull unsigned long long
#define ld long double
#define vi vector<int>
#define vll vector<long long>
#define vb vector<bool>
#define vs vector<string>
#define pii pair<int, int>
#define pll pair<long long, long long>
#define vpi vector<pair<int, int>>
#define vpll vector<pair<long long, long long>>

// Shortcuts
#define pb push_back
#define mp make_pair
#define fi first
#define se second
#define sz(x) ((int)(x).size())
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()

// Loop macros
#define FOR(i, a, b) for (int i = (a); i < (b); i++)
#define RFOR(i, a, b) for (int i = (a); i >= (b); i--)
#define REP(i, n) FOR(i, 0, n)
#define RREP(i, n) RFOR(i, n-1, 0)

// Constants
const int MOD = 1e9 + 7;
const int INF = 1e9;
const ll LINF = 1e18;
const double EPS = 1e-9;
const double PI = acos(-1.0);

// Directions for grid problems
const int dx[] = {-1, 1, 0, 0};
const int dy[] = {0, 0, -1, 1};
const int dx8[] = {-1, -1, -1, 0, 0, 1, 1, 1};
const int dy8[] = {-1, 0, 1, -1, 1, -1, 0, 1};

// Utility functions
template<typename T>
void print_vector(const vector<T>& v) {
    for (const auto& x : v) cout << x << " ";
    cout << "\n";
}

template<typename T>
void read_vector(vector<T>& v, int n) {
    v.resize(n);
    for (int i = 0; i < n; i++) cin >> v[i];
}

// Math utilities
ll gcd(ll a, ll b) { return b ? gcd(b, a % b) : a; }
ll lcm(ll a, ll b) { return a / gcd(a, b) * b; }
ll power(ll a, ll b, ll mod = MOD) {
    ll res = 1;
    while (b > 0) {
        if (b & 1) res = (res * a) % mod;
        a = (a * a) % mod;
        b >>= 1;
    }
    return res;
}

// Binary search templates
template<typename T>
T binary_search_first_true(T left, T right, function<bool(T)> check) {
    while (left < right) {
        T mid = left + (right - left) / 2;
        if (check(mid)) right = mid;
        else left = mid + 1;
    }
    return left;
}

template<typename T>
T binary_search_last_true(T left, T right, function<bool(T)> check) {
    while (left < right) {
        T mid = left + (right - left + 1) / 2;
        if (check(mid)) left = mid;
        else right = mid - 1;
    }
    return left;
}

// Debug macro (comment out for submission)
#ifdef LOCAL
#define debug(x) cerr << #x << " = " << x << endl
#define debug2(x, y) cerr << #x << " = " << x << ", " << #y << " = " << y << endl
#else
#define debug(x)
#define debug2(x, y)
#endif

void solve() {
    // Your solution code here
    
}

int main() {
    fast_io;
    
    int t = 1;
    cin >> t;  // Comment this line if single test case
    
    while (t--) {
        solve();
    }
    
    return 0;
}
