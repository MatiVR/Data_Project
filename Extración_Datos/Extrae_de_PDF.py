{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "9b8bca2f-a748-49d7-81fd-d1823e56a698",
   "metadata": {},
   "outputs": [],
   "source": [
    "import camelot\n",
    "\n",
    "tables = camelot.read_pdf('foo.pdf', pages='1', flavor='lattice')\n",
    "print(tables)\n",
    "\n",
    "tables.export('foo.csv', f='csv', compress=True)\n",
    "tables[0].to_csv('foo.csv')  # to a csv file\n",
    "print(tables[0].df)  # to a df"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python [conda env:base] *",
   "language": "python",
   "name": "conda-base-py"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
