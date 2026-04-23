-- DropForeignKey
ALTER TABLE "Dataset" DROP CONSTRAINT "Dataset_sourceId_fkey";

-- DropForeignKey
ALTER TABLE "Record" DROP CONSTRAINT "Record_datasetId_fkey";

-- DropForeignKey
ALTER TABLE "RecordTag" DROP CONSTRAINT "RecordTag_recordId_fkey";

-- DropForeignKey
ALTER TABLE "RecordTag" DROP CONSTRAINT "RecordTag_tagId_fkey";

-- AlterTable
ALTER TABLE "User" ADD COLUMN "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- DropTable
DROP TABLE "RecordTag";

-- DropTable
DROP TABLE "Tag";

-- DropTable
DROP TABLE "Record";

-- DropTable
DROP TABLE "DatasetSource";

-- DropTable
DROP TABLE "Dataset";