/*
  Warnings:

  - You are about to drop the column `source` on the `Dataset` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[datasetId,subjectId,sessionId,path]` on the table `Record` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "RecordTag" DROP CONSTRAINT "RecordTag_recordId_fkey";

-- DropForeignKey
ALTER TABLE "RecordTag" DROP CONSTRAINT "RecordTag_tagId_fkey";

-- AlterTable
ALTER TABLE "Dataset" DROP COLUMN "source",
ADD COLUMN     "sourceId" TEXT,
ADD COLUMN     "version" TEXT;

-- AlterTable
ALTER TABLE "Record" ADD COLUMN     "checksum" TEXT,
ADD COLUMN     "modality" TEXT,
ADD COLUMN     "path" TEXT,
ADD COLUMN     "sessionId" TEXT,
ADD COLUMN     "subjectId" TEXT;

-- CreateTable
CREATE TABLE "DatasetSource" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT,

    CONSTRAINT "DatasetSource_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DatasetSource_name_key" ON "DatasetSource"("name");

-- CreateIndex
CREATE INDEX "Record_datasetId_idx" ON "Record"("datasetId");

-- CreateIndex
CREATE INDEX "Record_subjectId_idx" ON "Record"("subjectId");

-- CreateIndex
CREATE INDEX "Record_modality_idx" ON "Record"("modality");

-- CreateIndex
CREATE INDEX "Record_externalId_idx" ON "Record"("externalId");

-- CreateIndex
CREATE UNIQUE INDEX "Record_datasetId_subjectId_sessionId_path_key" ON "Record"("datasetId", "subjectId", "sessionId", "path");

-- CreateIndex
CREATE INDEX "RecordTag_tagId_idx" ON "RecordTag"("tagId");

-- AddForeignKey
ALTER TABLE "Dataset" ADD CONSTRAINT "Dataset_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "DatasetSource"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecordTag" ADD CONSTRAINT "RecordTag_recordId_fkey" FOREIGN KEY ("recordId") REFERENCES "Record"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecordTag" ADD CONSTRAINT "RecordTag_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "Tag"("id") ON DELETE CASCADE ON UPDATE CASCADE;
