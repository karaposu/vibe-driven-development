BRILLIANT! You're describing a progressive testing strategy that matches how developers actually work. Let's call them "Probe Tests"
  - they probe the system to both verify basic operation AND discover actual behavior.

  Probe Tests: Smoke + Discover + Validate in One

  """
  PROBE TEST: A hybrid that:
  1. ✓ Checks it runs (smoke)
  2. 🔍 Discovers how it behaves (explore)
  3. ⚠️ Validates critical assumptions (verify)
  """

  The Probe Test Philosophy

  Create PROBE TESTS that simultaneously verify the code works AND teach us how it actually behaves.

  Each test should:
  1. SMOKE: Verify it doesn't crash
  2. DISCOVER: Learn actual behavior through observation
  3. VALIDATE: Check if critical assumptions hold

  This gives us safety + learning in one fast test.

  Probe Test Structure

  def probe_user_registration():
      """
      PROBING: User registration system
      ✓ Verify: It runs without crashing
      🔍 Discover: What it actually returns and accepts
      ⚠️ Validate: Critical security/business rules are met
      """

      print("\n🔬 PROBING: User Registration")

      # STEP 1: SMOKE - Does it even work?
      print("  [SMOKE] Testing basic operation...")
      try:
          result = register_user("test@example.com", "password123")
          print(f"    ✓ Runs without crashing")
          print(f"    ✓ Returns: {type(result)}")
      except Exception as e:
          print(f"    ✗ FAILED: {e}")
          return False

      # STEP 2: DISCOVER - What does it actually do?
      print("  [DISCOVER] Learning behavior...")
      print(f"    → Result type: {type(result)}")
      print(f"    → Result value: {result}")
      if hasattr(result, '__dict__'):
          print(f"    → Attributes: {list(result.__dict__.keys())}")

      # Try variations to map behavior
      duplicate = register_user("test@example.com", "password123")
      print(f"    → Duplicate attempt: {duplicate}")
      print(f"    → Same user allowed? {duplicate is not None}")

      weak_pass = register_user("test2@example.com", "123")
      print(f"    → Weak password result: {weak_pass}")

      # STEP 3: VALIDATE - Critical things that MUST be true
      print("  [VALIDATE] Checking critical requirements...")

      # Critical validation 1: No plaintext passwords
      if hasattr(result, 'password'):
          assert result.password != "password123", "❌ CRITICAL: Password stored in plaintext!"
          print(f"    ✓ Password is hashed: {result.password[:20]}...")

      # Critical validation 2: User ID exists
      assert hasattr(result, 'id') or 'id' in result, "❌ CRITICAL: No user ID returned!"
      print(f"    ✓ User ID present: {result.id if hasattr(result, 'id') else result['id']}")

      # Critical validation 3: Duplicate emails blocked
      assert duplicate is None or duplicate.error, "❌ CRITICAL: Duplicate emails allowed!"
      print(f"    ✓ Duplicates blocked")

      print("  [RESULT] Registration: OPERATIONAL + UNDERSTOOD + VALIDATED ✓")
      return True

  Complete Probe Test Example

  """
  PROBE TESTS: Smart testing that learns while validating
  Run: python probe_tests.py

  These tests:
  1. Verify code runs (smoke)
  2. Discover actual behavior (explore)  
  3. Validate critical requirements (verify)
  """

  def probe_calculation_engine():
      """Probe the calculation engine to understand and validate it"""

      print("\n🔬 PROBING: Calculation Engine")

      # SMOKE: Does it work at all?
      try:
          result = calculate(10, 20, "add")
          print(f"  ✓ Basic operation works: 10+20={result}")
      except Exception as e:
          print(f"  ✗ BROKEN: {e}")
          return False

      # DISCOVER: How does it actually work?
      print("  [DISCOVERING behavior...]")

      # What operations are supported?
      ops = ["add", "subtract", "multiply", "divide", "power", "unknown"]
      for op in ops:
          try:
              r = calculate(10, 2, op)
              print(f"    {op:10} -> {r}")
          except:
              print(f"    {op:10} -> not supported")

      # How does it handle edge cases?
      edge_cases = [
          (0, 0, "add", "zeros"),
          (5, 0, "divide", "div by zero"),
          (-5, 3, "add", "negative"),
          (1.5, 2.5, "add", "decimals"),
          (None, 5, "add", "null input"),
      ]

      print("  [DISCOVERING edge cases...]")
      for a, b, op, desc in edge_cases:
          try:
              r = calculate(a, b, op)
              print(f"    {desc:12} -> {r}")
          except Exception as e:
              print(f"    {desc:12} -> {type(e).__name__}")

      # VALIDATE: Critical requirements
      print("  [VALIDATING critical rules...]")

      # Must handle division by zero safely
      try:
          div_zero = calculate(5, 0, "divide")
          assert div_zero != float('inf'), "❌ Returns infinity instead of error!"
          print(f"    ✓ Div by zero handled: {div_zero}")
      except:
          print(f"    ✓ Div by zero raises exception (good)")

      # Basic math must be correct
      assert calculate(2, 3, "add") == 5, "❌ Basic math wrong!"
      assert calculate(10, 3, "subtract") == 7, "❌ Subtraction wrong!"
      print(f"    ✓ Basic math correct")

      # Must preserve precision for money calculations
      money_result = calculate(0.1, 0.2, "add")
      if abs(money_result - 0.3) < 0.0001:
          print(f"    ✓ Decimal precision OK: 0.1+0.2={money_result}")
      else:
          print(f"    ⚠️ Decimal precision issue: 0.1+0.2={money_result}")

      return True


  def probe_data_pipeline():
      """Probe how data flows through the system"""

      print("\n🔬 PROBING: Data Pipeline")

      # SMOKE
      test_data = {"name": "Alice", "age": 30}
      try:
          result = process_data(test_data)
          print(f"  ✓ Pipeline runs: {test_data} -> {type(result)}")
      except Exception as e:
          print(f"  ✗ Pipeline broken: {e}")
          return False

      # DISCOVER
      print("  [DISCOVERING transformations...]")
      print(f"    Input:  {test_data}")
      print(f"    Output: {result}")

      # What fields are added/removed?
      added = set(result.keys()) - set(test_data.keys())
      removed = set(test_data.keys()) - set(result.keys())
      print(f"    Added fields: {added}")
      print(f"    Removed fields: {removed}")

      # How are types transformed?
      for key in test_data:
          if key in result:
              print(f"    {key}: {type(test_data[key]).__name__} -> {type(result[key]).__name__}")

      # VALIDATE
      print("  [VALIDATING critical rules...]")

      # Personal data must not be leaked
      sensitive = ["password", "ssn", "credit_card"]
      leaked = [s for s in sensitive if s in str(result).lower()]
      assert not leaked, f"❌ Sensitive data leaked: {leaked}"
      print(f"    ✓ No sensitive data in output")

      # Required fields must exist
      assert "id" in result or "user_id" in result, "❌ No ID field!"
      print(f"    ✓ ID field present")

      # Data integrity - name shouldn't change
      if "name" in result:
          assert result["name"] == test_data["name"], "❌ Data corrupted!"
          print(f"    ✓ Data integrity maintained")

      return True


  def probe_api_authentication():
      """Probe the API auth to understand and validate security"""

      print("\n🔬 PROBING: API Authentication")

      # SMOKE - Can we even call the API?
      try:
          public_result = api_call("/health", auth=None)
          print(f"  ✓ Public endpoint works: {public_result.status}")
      except Exception as e:
          print(f"  ✗ API unreachable: {e}")
          return False

      # DISCOVER - How does auth actually work?
      print("  [DISCOVERING auth behavior...]")

      # Try different auth methods
      auth_methods = [
          ("Bearer fake-token", "Bearer token"),
          ("Basic dXNlcjpwYXNz", "Basic auth"),
          ("ApiKey 12345", "API key"),
          ("fake-token", "Plain token"),
      ]

      for auth, desc in auth_methods:
          try:
              r = api_call("/protected", auth=auth)
              print(f"    {desc:15} -> Status {r.status}")
          except:
              print(f"    {desc:15} -> Rejected")

      # Get a real token
      real_auth = login_and_get_token("user", "pass")
      print(f"    Real auth type: {type(real_auth)}")

      # VALIDATE - Critical security requirements
      print("  [VALIDATING security...]")

      # Protected endpoints MUST require auth
      try:
          r = api_call("/user/profile", auth=None)
          assert r.status == 401, f"❌ Protected endpoint returned {r.status} without auth!"
      except:
          print(f"    ✓ Protected endpoints require auth")

      # Valid auth MUST work
      r = api_call("/user/profile", auth=real_auth)
      assert r.status == 200, f"❌ Valid auth failed: {r.status}"
      print(f"    ✓ Valid auth accepted")

      # Expired tokens must fail (if we can test it)
      expired = "Bearer expired-token-for-testing"
      r = api_call("/user/profile", auth=expired)
      assert r.status != 200, "❌ Expired token still works!"
      print(f"    ✓ Invalid tokens rejected")

      return True


  # Run all probes
  if __name__ == "__main__":
      probes = [
          probe_calculation_engine,
          probe_data_pipeline,
          probe_api_authentication,
      ]

      print("="*60)
      print("PROBE TESTS: Smoke + Discover + Validate")
      print("="*60)

      results = []
      for probe in probes:
          try:
              success = probe()
              results.append((probe.__name__, success))
          except Exception as e:
              print(f"\n❌ {probe.__name__} CRASHED: {e}")
              results.append((probe.__name__, False))

      print("\n" + "="*60)
      print("PROBE RESULTS:")
      for name, success in results:
          status = "✓ PASS" if success else "✗ FAIL"
          print(f"  {status} - {name}")

      passed = sum(1 for _, s in results if s)
      print(f"\nOverall: {passed}/{len(results)} probes passed")
      print("="*60)

  Why Probe Tests Are Perfect for AI Development

  1. Fast Feedback - One test gives you three types of information
  2. Self-Documenting - Output shows what the code actually does
  3. Resilient - Still useful even if code changes
  4. Educational - AI learns from discoveries for next iteration
  5. Safety Net - Critical validations prevent dangerous bugs

  The Probe Test Prompt

  Create PROBE TESTS that verify operation, discover behavior, and validate critical requirements.

  Each probe should have three phases:
  1. SMOKE: Check basic operation works
  2. DISCOVER: Learn how it actually behaves
  3. VALIDATE: Verify critical requirements are met

  Structure:
  - 3-5 probe test functions
  - Each completes in <10 seconds
  - Output should be educational AND diagnostic

  Format each probe as:
  [SMOKE] → Does it run?
  [DISCOVER] → How does it behave?
  [VALIDATE] → Are critical rules met?

  Focus on learning while ensuring safety.

  This gives you the speed of smoke tests, the learning of discovery tests, and the safety of validation tests - all in one!