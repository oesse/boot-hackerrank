#pragma once
#include <algorithm>
#include <istream>
#include <iterator>
#include <string>
#include <vector>

auto parseInputSize(std::istream &in) {
  size_t n;
  in >> n;
  in.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
  return n;
}

auto parseInput(std::istream &in) {
  auto n = parseInputSize(in);

  std::vector<std::string> v;
  v.reserve(n);
  std::generate_n(back_inserter(v), n, [&in] {
    std::string line;
    std::getline(in, line);
    return line;
  });

  return v;
}

struct Problem {
  int x, y, k;
};

auto parseProblem(const std::string &line) {
  Problem p;
  const char *start = line.c_str();
  char *end;

  p.x = std::strtol(start, &end, 10);

  start = end;
  p.y = std::strtol(start, &end, 10);

  start = end;
  p.k = std::strtol(start, &end, 10);

  return p;
}

auto initialPermutation(int x, int y) {
  return std::string(x, 'H') + std::string(y, 'V');
}

template <typename T, typename Op>
auto apply_n(size_t n, T &&initial, Op op) {
  T current = std::forward<T>(initial);
  for (size_t i = 0ul; i < n; ++i) {
    current = op(std::move(current));
  }
  return current;
}

auto findSolution(const std::string &line) {
  auto problem = parseProblem(line);
  auto permutation = initialPermutation(problem.x, problem.y);
  permutation = apply_n(problem.k, std::move(permutation), [](auto p) {
    std::next_permutation(begin(p), end(p));
    return p;
  });
  return permutation;
}

auto findSolutions(const std::vector<std::string> &v) {
  std::vector<std::string> s;
  s.reserve(v.size());
  std::transform(begin(v), end(v), back_inserter(s), findSolution);
  return s;
}

auto printSolution(std::ostream &out, const std::vector<std::string> &s) {
  std::copy(begin(s), end(s), std::ostream_iterator<std::string>(out, "\n"));
}
