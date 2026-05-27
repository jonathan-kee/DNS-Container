# Syntax Reference
https://yaml.org/spec/1.2.2/#chapter-2-language-overview

There are many kinds of data structures, but they can all be adequately represented with three basic primitives: 
1) Scalars (strings/numbers)
2) Sequences (arrays/lists) 
3) Mappings (hashes/dictionaries)  

Question: Why in Collections.yml, there are Nesting uses indentation & Sequences (equivalent to lists or arrays), what's the difference, which one should I use? So Maps is like Java's class, Sequences is like Java's array, Combining them will be like an Java's array of class?

Recap
### Nesting uses indentation. 2 space indent is preferred (but not required).
a_nested_map:
  key: value
  another_key: Another Value
  another_nested_map:
    hello: hello

###  Sequences (equivalent to lists or arrays) look like this
###  (note that the '-' counts as indentation):
a_sequence:
  - Item 1
  - Item 2
  - 0.5  # sequences can contain disparate types.
  - Item 4
  - key: value
    another_key: another_value
  - - This is a sequence
    - inside another sequence
  - - - Nested sequence indicators
      - can be collapsed

Answer: (Gemini)
Spot on. You’ve translated it perfectly into Java terms.

Here is exactly how that mapping looks under the hood:

---

## 1. YAML Key to Scalar

**YAML:**

```yaml
name: My First Workflow

```

**Java Equivalent:**

```java
// As a field in a configuration class
public class WorkflowConfig {
    public String name = "My First Workflow";
}

// Or as a generic Map entry
Map<String, String> config = new HashMap<>();
config.put("name", "My First Workflow");

```

---

## 2. YAML Maps $\approx$ Java Objects / HashMaps

When you use nesting with indentation in YAML, you are defining fields and values, just like the fields in a Java class or the keys in a `HashMap<String, Object>`.

**YAML:**

```yaml
user:
  name: "Alice"
  age: 30

```

**Java Equivalent:**

```java
// Strongly Typed Approach
public class Config {
    public User user; // Matches the root "user:" key
}

public class User {
    public String name = "Alice";
    public int age = 30;
}

// Generic/Dynamic Approach
Map<String, Map<String, Object>> config = new HashMap<>();

```

---

## 3. YAML Sequences $\approx$ Java Arrays / Lists

The dashes represent an ordered collection, exactly like a `String[]` array or an `ArrayList<String>`.

**YAML:**

```yaml
fruits:
  - "Apple"
  - "Banana"

```

**Java Equivalent:**

```java
// Strongly Typed Approach
public class FruitConfig {
    public String[] fruits = {"Apple", "Banana"};
}

// Generic/Dynamic Approach
Map<String, List<String>> config = new HashMap<>();

```

---

## 4. Combining Them $\approx$ An Array of Objects

When you see a sequence where each item contains indented key-value pairs, it is precisely an **array of objects** (or a `List<Employee>`).

**YAML:**

```yaml
# A sequence (array) of maps (objects)
employees:
  - name: "Alice"
    role: "DevOps"
  - name: "Bob"
    role: "QA"

```

**Java Equivalent:**

```java
// Strongly Typed Approach (Best Practice)
public class RootConfig {
    public Employee[] employees; // Matches the root "employees:" key
}

public class Employee {
    public String name;
    public String role;
    
    public Employee() {} // Default constructor used by parsers
    
    public Employee(String name, String role) {
        this.name = name;
        this.role = role;
    }
}

// Generic Approach (How parsers handle YAML's dynamic typing under the hood)
Map<String, List<Map<String, Object>>> config = new HashMap<>();

```

Because YAML is dynamically typed, a YAML sequence can technically hold completely different classes in the same array (e.g., item 1 is a `User`, item 2 is a plain `String`, item 3 is an `Integer`), which is like a Java `Object[]` array. But in practice, especially in configuration management, you'll almost always see them used as a clean array of a specific object type.

# More References
https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax

https://learnxinyminutes.com/yaml/