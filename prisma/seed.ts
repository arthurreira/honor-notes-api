import { PrismaClient } from "../generated/prisma/client.ts";
const prisma = new PrismaClient();

async function main() {
  await prisma.user.upsert({
    where: { email: "admin@example.com" },
    update: { name: "Admin" },
    create: {
      email: "admin@example.com",
      name: "Admin",
    },
  });

  console.log("User seed complete");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });