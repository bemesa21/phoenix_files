# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixFiles.Repo.insert!(%PhoenixFiles.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

books = [%{
  title: "Sarah MacLean",
  category: "Suspenso",
  category: ["Fantasy","Horror"],
  price: 100,
  cover: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1572296390-51fiEAOae4L.jpg"
},
%{
  title: "Run, Rose, Run",
  category: ["Novel", "Literary Fiction"],
  price: 100,
  cover: "https://www.littlebrown.com/wp-content/uploads/2022/01/9780759554344.jpg?fit=1673%2C2600",
  description: "Every song tells a story. She’s a star on the rise, singing about the hard life behind her. She’s also on the run. Find a future, lose a past. "

},
%{
  title: "Carrie",
  category: ["Fantasy","Horror"],
  price: 100,
  cover: "https://www.littlebrown.com/wp-content/uploads/2022/01/9780759554344.jpg?fit=1673%2C2600",
  description: "Every song tells a story. She’s a star on the rise, singing about the hard life behind her. She’s also on the run. Find a future, lose a past. "
}]
for book <- books do
  PhoenixFiles.Book.insert_book(book)
end
