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

books = [
  %{
    title: "Brazen and the beast",
    description:
      "NewYork Times Bestselling Author Sarah MacLean returns with the next book in the Bareknuckle Bastards series about three brothers bound by a secret that they cannot escape—and the women who bring them to their knees.",
    category: ["Romance", "Novel"],
    price: 100,
    cover: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1572296390-51fiEAOae4L.jpg"
  },
  %{
    title: "Run, Rose, Run",
    category: ["Novel", "Literary Fiction"],
    price: 100,
    cover: "https://www.littlebrown.com/wp-content/uploads/2022/01/9780759554344.jpg",
    description:
      "Every song tells a story. She’s a star on the rise, singing about the hard life behind her. She’s also on the run. Find a future, lose a past. "
  },
  %{
    title: "Carrie",
    category: ["Fantasy", "Horror"],
    price: 100,
    cover: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1572295234-51dRjo8NJeL.jpg",
    description:
      "Unpopular at school and subjected to her mother's religious fanaticism at home, Carrie White does not have it easy< q "
  },
  %{
    title: "One Hundred Years of Solitude",
    category: ["Historical Fiction"],
    price: 100,
    cover: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1572294012-51Zr6Pd32ML.jpg",
    description:
      "This engaging summary presents an analysis of One Hundred Years of Solitude by Gabriel García Márquez, which features a family who are cursed to one hundred years of oblivion"
  },
  %{
    title: "One World The Water Dancer",
    category: ["Fantasy"],
    price: 100,
    cover: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1572293716-51ItgiZw5dL.jpg",
    description:
      "oung Hiram Walker was born into bondage. When his mother was sold away, Hiram was robbed of all memory of her—but was gifted with a mysterious power."
  }
]

for book <- books do
  PhoenixFiles.Book.insert_book(book)
end
