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

## 1. YAML Maps $\approx$ Java Objects / HashMaps

When you use nesting with indentation in YAML, you are defining fields and values, just like the fields in a Java class or the keys in a `HashMap<String, Object>`.

**YAML:**

```yaml
user:
  name: "Alice"
  age: 30

```

**Java Equivalent:**

```java
public class User {
    public String name = "Alice";
    public int age = 30;
}
// Or alternatively: Map<String, Object> user = new HashMap<>();

```

---

## 2. YAML Sequences $\approx$ Java Arrays / Lists

The dashes represent an ordered collection, exactly like a `String[]` array or an `ArrayList<String>`.

**YAML:**

```yaml
fruits:
  - "Apple"
  - "Banana"

```

**Java Equivalent:**

```java
String[] fruits = {"Apple", "Banana"};
// Or: List<String> fruits = Arrays.asList("Apple", "Banana");

```

---

## 3. Combining Them $\approx$ An Array of Objects

When you see a sequence where each item contains indented key-value pairs, it is precisely an **array of objects** (or a `List<User>`).

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
public class Employee {
    public String name;
    public String role;
    
    public Employee(String name, String role) {
        this.name = name;
        this.role = role;
    }
}

// Combining them into an array
Employee[] employees = {
    new Employee("Alice", "DevOps"),
    new Employee("Bob", "QA")
};

```

Because YAML is dynamically typed, a YAML sequence can technically hold completely different classes in the same array (e.g., item 1 is a `User`, item 2 is a plain `String`, item 3 is an `Integer`), which is like a Java `Object[]` array. But in practice, especially in configuration management, you'll almost always see them used as a clean array of a specific object type.

# More References
https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax

https://learnxinyminutes.com/yaml/