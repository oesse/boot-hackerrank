#include "solution.hpp"
#include <iostream>

int main() {
  auto v = parseInput(std::cin);
  auto s = findSolutions(v);
  printSolution(std::cout, s);
  return 0;
}
