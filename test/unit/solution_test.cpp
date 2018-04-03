#include "solution.hpp"
#include <sstream>
#include <catch.hpp>

using namespace std;
using Catch::Matchers::Equals;

TEST_CASE("parseInput returns a vector of lines") {
  istringstream ss;
  ss.str("2\n1 2 3\n4 5 6");

  auto v = parseInput(ss);
  auto expected = vector<string>{"1 2 3"s, "4 5 6"s};
  REQUIRE_THAT(v, Equals(expected));
}

TEST_CASE("findSolutions returns as many solutions as it has input lines") {
  auto v = vector<string>{"2 2 1"s, "3 5 2"s};
  auto s = findSolutions(v);
  REQUIRE(s.size() == 2);
}

TEST_CASE("parseProblem returns integers x, y and k from line") {
  auto line = "2 1 0"s;
  auto p = parseProblem(line);
  REQUIRE(p.x == 2);
  REQUIRE(p.y == 1);
  REQUIRE(p.k == 0);
}

TEST_CASE("findSolution with k=0 returns the initial permutation of Hs and Vs") {
  auto line = "2 2 0"s;
  auto solution = findSolution(line);
  REQUIRE(solution == "HHVV");
}

TEST_CASE("findSolution k!=0 returns the kth lexigraphic permutation of Hs and Vs") {
  auto line = "2 2 1"s;
  auto solution = findSolution(line);
  REQUIRE(solution == "HVHV");
}
