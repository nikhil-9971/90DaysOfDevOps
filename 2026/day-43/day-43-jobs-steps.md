# needs: and outputs: in GitHub Actions

needs: ka use job dependencies define karne ke liye hota hai.
Iska matlab hai ki ek job tabhi run karegi jab jis job ko wo need karti hai wo successfully complete ho jaye.


outputs: ka use ek job se dusri job ko data pass karne ke liye hota hai.

```yaml

outputs:
  date: ${{ steps.date_step.outputs.date }}

  ```
Yaha job date value generate karti hai, aur next job ise read kar sakti hai.

Next job me use karna:

```yaml

${{ needs.generate-date.outputs.date }}

```

Thanks