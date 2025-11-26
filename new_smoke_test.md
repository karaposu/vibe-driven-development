Let's design comprehensive validation tests that verify our implementation produces CORRECT results, not just that it runs.

  Please create validation_tests folder with the following structure:

  ## 1. Test Design Philosophy
  Each test must verify CORRECTNESS by:
  - Using known inputs that have mathematically/logically certain outputs
  - Comparing actual results with expected ground truth values
  - Testing relative behaviors (if A > B in input, verify A' > B' in output)
  - Verifying what should NOT happen (negative testing)

  ## 2. Test Structure
  Create 5 test files with this naming: test_01_[area]_validation.py
  Each file should contain 5-7 test cases organized as:
  - 2 ground truth tests (known input → exact expected output)
  - 2 property verification tests (mathematical/logical properties that must hold)
  - 1-2 negative tests (what should fail/not happen)
  - 1 edge case test (boundaries, limits, unusual inputs)

  ## 3. Test Implementation Requirements

  ### For EACH test case, you must:
  ```python
  def test_something_specific():
      """Test that [specific behavior] produces [exact expected result]"""

      # ARRANGE: Set up test with KNOWN input
      test_input = create_specific_known_input()  # Document WHY this input
      expected_output = known_correct_answer()     # Document HOW we know this

      # ACT: Run the actual code
      actual_output = function_under_test(test_input)

      # ASSERT: Verify EXACT correctness
      # Don't just check "not None" or "has data"
      # Check the ACTUAL VALUES match EXPECTED VALUES
      if actual_output != expected_output:
          print(f"❌ FAILED: {test_name}")
          print(f"  Input: {test_input}")
          print(f"  Expected: {expected_output}")
          print(f"  Actual: {actual_output}")
          print(f"  Difference: {explain_difference()}")
          return False

      print(f"✅ PASSED: {test_name}")
      print(f"  Verified: {what_was_verified}")
      return True

  4. Types of Validation Tests to Include

  A. Ground Truth Tests

  # GOOD: Exact verification
  def test_addition_exact():
      result = calculator.add(2, 3)
      assert result == 5, f"2+3 must equal 5, got {result}"

  # BAD: Vague verification  
  def test_addition_smoke():
      result = calculator.add(2, 3)
      assert result is not None  # This would pass even if result was 999!

  B. Property Tests

  def test_sorting_properties():
      data = [3, 1, 4, 1, 5]
      sorted_data = sort_function(data)

      # Property 1: Length preserved
      assert len(sorted_data) == len(data)

      # Property 2: Monotonic increase
      for i in range(len(sorted_data)-1):
          assert sorted_data[i] <= sorted_data[i+1]

      # Property 3: Same elements (permutation)
      assert sorted(data) == sorted(sorted_data)

  C. Relative Behavior Tests

  def test_search_relevance():
      results_exact = search("python")
      results_fuzzy = search("pythn")  # Typo

      # Exact match MUST rank higher than fuzzy match
      assert results_exact[0].score > results_fuzzy[0].score

  D. Negative Tests

  def test_invalid_inputs():
      # Should handle invalid input gracefully
      result = divide(5, 0)
      assert result.error == "Division by zero"
      assert result.value is None  # Must not return Infinity or crash

  E. Edge Cases

  def test_boundary_conditions():
      # Test at exact limits
      assert process_age(0) == "infant"     # Minimum
      assert process_age(150) == "invalid"  # Maximum exceeded
      assert process_age(-1) == "invalid"   # Below minimum

  5. Test File Template

  """
  Test: [Specific Component/Feature] Validation
  Run: python test_01_[area]_validation.py

  This validates that [component] produces mathematically/logically correct results.
  Critical because: [why correctness matters for this component]

  Test Cases:
  1. [test_name]: Verify exact output for known input
  2. [test_name]: Verify mathematical property X holds
  3. [test_name]: Verify relative behavior Y
  4. [test_name]: Verify failure case Z handled correctly
  5. [test_name]: Verify edge case W
  """

  def test_known_case_simple():
      """Test with simplest possible known input/output"""
      # Use minimal input where output is obvious
      input_data = [1, 2, 3]
      expected = 6  # Sum is definitely 6

      actual = sum_function(input_data)

      if actual != expected:
          print(f"❌ Basic sum failed: {input_data} -> {actual} (expected {expected})")
          return False
      print(f"✅ Basic sum correct: {input_data} -> {actual}")
      return True

  def test_mathematical_property():
      """Test that mathematical properties hold"""
      # Example: sum(A) + sum(B) == sum(A + B)
      a = [1, 2, 3]
      b = [4, 5, 6]

      sum_a = sum_function(a)
      sum_b = sum_function(b)
      sum_combined = sum_function(a + b)

      if sum_a + sum_b != sum_combined:
          print(f"❌ Additive property failed: {sum_a} + {sum_b} != {sum_combined}")
          return False
      print(f"✅ Additive property holds")
      return True

  # ... more tests ...

  if __name__ == "__main__":
      tests = [
          test_known_case_simple,
          test_mathematical_property,
          # ...
      ]

      passed = 0
      failed = 0

      for test in tests:
          try:
              if test():
                  passed += 1
              else:
                  failed += 1
          except Exception as e:
              print(f"❌ {test.__name__} CRASHED: {e}")
              failed += 1

      print(f"\n{'='*50}")
      print(f"Results: {passed} passed, {failed} failed")
      if failed == 0:
          print("✅ ALL VALIDATION TESTS PASSED")
      else:
          print("⚠️ VALIDATION FAILURES DETECTED")

  6. What to Validate for Different Components

  For Data Processing:

  - Known input → exact output
  - Preserve data properties (no data loss)
  - Handle empty/null/invalid inputs correctly
  - Verify transformations are reversible (if applicable)

  For APIs/Services:

  - Correct status codes for each scenario
  - Response format matches specification exactly
  - Error messages are specific and helpful
  - Rate limiting actually enforces limits

  For UI Components:

  - User actions produce exact expected state changes
  - Disabled states actually prevent actions
  - Form validation catches all invalid cases
  - Accessibility attributes present and correct

  For Business Logic:

  - Calculations produce exact expected amounts
  - Rules apply in correct order
  - Permissions actually enforced
  - Audit trails capture all changes

  7. Key Improvements Over Smoke Tests

  Instead of: "Did the function return something?"
  Validate: "Did it return the CORRECT thing?"

  Instead of: "Did the API respond?"
  Validate: "Did it respond with correct status, headers, and body?"

  Instead of: "Did the file save?"
  Validate: "Did it save with correct content, permissions, and location?"

  Instead of: "Did it handle the error?"
  Validate: "Did it handle it the RIGHT way with proper cleanup?"

  ## Key Differences from Your Original Prompt

  1. **Ground Truth Focus** - Every test verifies against known correct answers
  2. **Exact Comparisons** - Not just "worked" but "produced exactly X"
  3. **Property Testing** - Verify mathematical/logical properties hold
  4. **Negative Testing** - Explicitly test what should NOT happen
  5. **Diagnostic Output** - Show expected vs actual, not just pass/fail

  ## Example Usage Comparison

  **Your Current Approach:**
  ```python
  def test_user_registration():
      user = register("alice@example.com", "password123")
      assert user is not None  # Smoke test
      print("✓ User registered")

  Validation Approach:
  def test_user_registration_validates_email():
      # Test exact validation behavior
      valid_user = register("alice@example.com", "Pass123!")
      assert valid_user.id is not None
      assert valid_user.email == "alice@example.com"

      invalid_user = register("not-an-email", "Pass123!")
      assert invalid_user is None  # Must reject invalid email

      duplicate_user = register("alice@example.com", "Other123!")
      assert duplicate_user is None  # Must reject duplicate

      print(f"✓ Email validation working correctly")


























YES! You've identified something really important - this is a completely different testing paradigm for AI-assisted development.
  Let's call them "Discovery Tests" or "Exploration Tests".

  Discovery Tests: Learning Through Failure

  This is how a developer actually explores unfamiliar code:

  """
  Not testing IF it works, but discovering HOW it works
  Not validating correctness, but understanding behavior
  """

  The Discovery Test Philosophy

  Create DISCOVERY TESTS that help us understand what the code actually does (vs what we think it does).

  ## Purpose: Learning, Not Validation
  - Reveal actual behavior through experimentation
  - Surface unexpected behaviors/assumptions
  - Document findings through test outputs
  - Fail informatively to teach us something

  ## Structure: Hypothesize → Test → Learn

  ### Each test should follow this pattern:
  ```python
  def discover_how_X_handles_Y():
      """
      HYPOTHESIS: I think X does _____ when given Y
      TESTING: Let me try it and see what actually happens
      """

      # Try something we're curious about
      print(f"\n🔍 Testing: What happens when {description}?")

      input = create_test_case()
      print(f"   Input: {input}")

      try:
          result = function_to_explore(input)
          print(f"   Output: {result}")
          print(f"   Type: {type(result)}")

          # Probe deeper - what's inside?
          if hasattr(result, '__dict__'):
              print(f"   Attributes: {result.__dict__}")
          if len(str(result)) > 100:
              print(f"   Size: {len(str(result))} chars")

          # Test our assumption
          print(f"   📊 Finding: {what_we_learned}")

      except Exception as e:
          print(f"   💥 Failed with: {type(e).__name__}: {e}")
          print(f"   📊 Finding: It doesn't handle this case")

      # Not pass/fail - just "what did we learn?"
      return what_we_discovered

  Example Discovery Test File

  """
  DISCOVERY TEST: Understanding the Authentication System
  Run: python discover_01_auth_behavior.py

  Goal: Figure out how auth actually works by trying things
  Not testing correctness - just mapping the territory
  """

  def discover_what_login_returns():
      """Let's see what login actually gives us"""

      print("\n🔍 What does login return on success?")

      result = login("admin@test.com", "password123")
      print(f"   Result type: {type(result)}")
      print(f"   Result value: {result}")

      if result:
          print(f"   Has .token? {hasattr(result, 'token')}")
          print(f"   Has .user? {hasattr(result, 'user')}")
          print(f"   Has .session? {hasattr(result, 'session')}")

          # Try to use it
          try:
              headers = {"Authorization": f"Bearer {result.token}"}
              print(f"   📊 Token format works: Bearer {result.token[:10]}...")
          except:
              try:
                  headers = {"Authorization": result}
                  print(f"   📊 Result itself might be the token")
              except:
                  print(f"   📊 Not sure how to use this for auth")

  def discover_password_requirements():
      """Let's find out what password rules exist"""

      print("\n🔍 Testing password requirements...")

      test_passwords = [
          ("", "empty"),
          ("a", "single char"),
          ("password", "simple word"),
          ("password123", "word + numbers"),
          ("Pass123!", "mixed case + special"),
          ("a" * 100, "very long"),
      ]

      for pwd, description in test_passwords:
          try:
              result = register("test@test.com", pwd)
              print(f"   ✓ {description:20} -> ACCEPTED")
              # Clean up
              delete_user("test@test.com")
          except Exception as e:
              print(f"   ✗ {description:20} -> REJECTED: {str(e)[:50]}")

      print(f"   📊 Finding: System accepts passwords that are ____")

  def discover_session_behavior():
      """How long do sessions last? What invalidates them?"""

      print("\n🔍 Exploring session lifecycle...")

      # Login and get session
      session1 = login("user@test.com", "pass")
      print(f"   Got session: {session1}")

      # Try using it immediately
      result = api_call_with_session(session1)
      print(f"   Immediate use: {result.status}")

      # Try using same credentials again
      session2 = login("user@test.com", "pass")
      print(f"   Second login: {session2}")
      print(f"   Same session? {session1 == session2}")

      # Is first session still valid?
      result = api_call_with_session(session1)
      print(f"   First session still works? {result.status}")

      print(f"   📊 Finding: Multiple sessions are {'allowed' if result.status == 200 else 'not allowed'}")

  def discover_error_messages():
      """What errors does the system actually return?"""

      print("\n🔍 Cataloging error responses...")

      scenarios = [
          (lambda: login("", ""), "empty credentials"),
          (lambda: login("notanemail", "pass"), "invalid email"),
          (lambda: login("user@test.com", "wrongpass"), "wrong password"),
          (lambda: login("nonexistent@test.com", "pass"), "unknown user"),
          (lambda: login("user@test.com", None), "null password"),
      ]

      errors_found = {}
      for action, scenario in scenarios:
          try:
              result = action()
              print(f"   {scenario:25} -> SUCCESS(?): {result}")
          except Exception as e:
              error_msg = str(e)
              print(f"   {scenario:25} -> {error_msg[:40]}")
              errors_found[scenario] = error_msg

      # Do different failures give different messages?
      unique_messages = len(set(errors_found.values()))
      print(f"   📊 Finding: {unique_messages} unique error messages")
      print(f"   📊 Finding: Errors {'reveal' if unique_messages > 1 else 'hide'} failure reasons")

  def discover_rate_limiting():
      """Is there rate limiting? When does it kick in?"""

      print("\n🔍 Probing for rate limits...")

      attempt = 0
      while attempt < 100:
          try:
              login("user@test.com", f"attempt{attempt}")
              attempt += 1
          except Exception as e:
              if "rate" in str(e).lower() or "too many" in str(e).lower():
                  print(f"   📊 Rate limit hit after {attempt} attempts")
                  print(f"   Error: {e}")
                  break
              attempt += 1

      if attempt == 100:
          print(f"   📊 No rate limiting found in 100 attempts!")

  # Run discoveries
  if __name__ == "__main__":
      discoveries = []

      print("="*60)
      print("DISCOVERY TESTS: Learning how the auth system actually works")
      print("="*60)

      discover_what_login_returns()
      discover_password_requirements()
      discover_session_behavior()
      discover_error_messages()
      discover_rate_limiting()

      print("\n" + "="*60)
      print("DISCOVERY COMPLETE - Now we understand:")
      print("- Login returns: _____")
      print("- Password rules: _____")
      print("- Session behavior: _____")
      print("- Error handling: _____")
      print("- Rate limiting: _____")
      print("="*60)

  Key Differences from Traditional Tests

  Smoke Test:

  def test_login():
      result = login("user", "pass")
      assert result is not None  # ✓ Pass

  Validation Test:

  def test_login():
      result = login("user@test.com", "ValidPass123!")
      assert result.token == "xyz..."  # Exact expectation

  Discovery Test:

  def discover_login():
      print("🔍 What does login actually return?")
      result = login("user", "pass")
      print(f"   Type: {type(result)}")  # Oh, it's a dict!
      print(f"   Keys: {result.keys()}")  # Has 'token', 'expires', 'refresh'
      print(f"   Token length: {len(result['token'])}")  # 36 chars, probably UUID
      print(f"   📊 Discovery: Returns dict with UUID token")

  Why This Is Perfect for AI Development

  1. No Assumptions - We're learning, not asserting
  2. Failure is Information - Errors teach us constraints
  3. Output is Documentation - The test output becomes our understanding
  4. Rapid Iteration Friendly - No need to update assertions when code changes
  5. AI Can Learn From Output - Feed results back to improve next iteration

  The Discovery Test Prompt

  Create DISCOVERY TESTS to understand how this code actually behaves.

  Purpose: Learn through experimentation, not validate assumptions
  - Try different inputs and observe what happens
  - Print everything interesting you discover
  - Errors are valuable data, not failures
  - Goal is understanding, not pass/fail

  For each behavior you're curious about:
  1. State what you're testing to discover
  2. Try it and print what happens
  3. Try variations to map the boundaries
  4. Summarize what you learned

  Format:
  ```python
  def discover_[what_you_want_to_know]():
      """I wonder what happens when..."""

      print("\n🔍 Discovering: [question]")

      # Try something
      result = some_operation(test_input)
      print(f"   Input: {test_input}")
      print(f"   Result: {result}")

      # Probe deeper
      print(f"   Type: {type(result)}")
      print(f"   Attributes: {dir(result)}")

      # Try edge cases
      edge_result = some_operation(edge_input)
      print(f"   Edge case: {edge_input} -> {edge_result}")

      # What did we learn?
      print(f"   📊 Discovery: [what this tells us]")

  Output should read like a lab notebook, not test results.

  This is exactly what developers do when exploring new code - poke it, see what happens, learn from the response. It's not testing,
  it's **active reconnaissance**!
