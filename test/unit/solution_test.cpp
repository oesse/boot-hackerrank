#include "solution.hpp"
#include <catch.hpp>

TEST_CASE("Solution should be universal") {
  REQUIRE(calculateSolution() == 42); 
}
