package org.flock;

import java.awt.BorderLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.WindowConstants;
import javax.swing.table.DefaultTableModel;

public class LibraryDBApp extends JFrame {

  private final transient LibraryDB libraryDB;
  private transient Book selectedBook;
  private transient BookPlace selectedBookPlace;
  private JTextField floorField;
  private JTextField bookcaseField;
  private JTextField shelfField;
  private static final String LABEL_FLOOR = "Этаж:";
  private static final String LABEL_BOOKCASE = "Шкаф:";
  private static final String INVALID_INPUT_MESSAGE = "Неверный ввод!";

  public LibraryDBApp() {
    libraryDB = new LibraryDB();

    setTitle("Домашняя библиотека");
    setSize(600, 400);
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    setLocationRelativeTo(null);
    initializeComponents();
  }

  private void initializeComponents() {
    JButton restoreDefaultValuesButton = new JButton("Заполнить таблицу");
    JButton addBookPlaceButton = new JButton("Добавить место");
    JButton addBookButton = new JButton("Добавить книгу");
    JButton getAllBookPlacesButton = new JButton("Показать все места");
    JButton getAllBooksButton = new JButton("Показать все книги");
    JButton getBooksByPlaceButton = new JButton("Книги по месту в библиотеке");
    JButton getPublishersButton = new JButton("Издательства на полке");
    JButton getHeaviestBookButton = new JButton("Самая тяжелая книга");
    JButton getLightestBookButton = new JButton("Самая легкая книга");

    JPanel buttonPanel = new JPanel();
    buttonPanel.add(restoreDefaultValuesButton);
    buttonPanel.add(addBookPlaceButton);
    buttonPanel.add(addBookButton);
    buttonPanel.add(getAllBookPlacesButton);
    buttonPanel.add(getAllBooksButton);
    buttonPanel.add(getBooksByPlaceButton);
    buttonPanel.add(getPublishersButton);
    buttonPanel.add(getHeaviestBookButton);
    buttonPanel.add(getLightestBookButton);

    JPanel mainPanel = new JPanel(new BorderLayout());
    mainPanel.add(buttonPanel, BorderLayout.SOUTH);

    add(mainPanel);

    restoreDefaultValuesButton.addActionListener(e -> restoreDefaultValues());
    addBookPlaceButton.addActionListener(e -> addBookPlace());
    addBookButton.addActionListener(e -> addBook());
    getAllBookPlacesButton.addActionListener(e -> getAllBookPlaces());
    getAllBooksButton.addActionListener(e -> getAllBooks());
    getBooksByPlaceButton.addActionListener(e -> getBooksByPlace());
    getPublishersButton.addActionListener(e -> getPublishersOnShelf());
    getHeaviestBookButton.addActionListener(e -> getHeaviestBook());
    getLightestBookButton.addActionListener(e -> getLightestBook());
  }

  private void restoreDefaultValues() {
    libraryDB.restoreDefaultValues();
    JOptionPane.showMessageDialog(this, "Таблица заполнена!", "Успех",
        JOptionPane.INFORMATION_MESSAGE);
  }

  private void addBookPlace() {
    JPanel inputPanel = createInputPanel();

    int result = JOptionPane.showConfirmDialog(this, inputPanel, "Добавить место",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int floor = Integer.parseInt(floorField.getText());
        int bookcase = Integer.parseInt(bookcaseField.getText());
        int shelf = Integer.parseInt(shelfField.getText());

        BookPlace bookPlace = new BookPlace(floor, bookcase, shelf);

        // Проверка наличия комбинации места книги в базе данных
        if (libraryDB.isBookPlaceExists(bookPlace)) {
          JOptionPane.showMessageDialog(this,
              "Место с такой комбинацией этажа, шкафа и полки уже существует!");
        } else {
          libraryDB.addBookPlace(bookPlace);
          JOptionPane.showMessageDialog(this, "Место успешно добавлено!");
        }
      } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this,
            INVALID_INPUT_MESSAGE);
      }
    }
  }

  private JPanel createInputPanel() {
    JPanel inputPanel = new JPanel(new GridBagLayout());
    GridBagConstraints gbc = new GridBagConstraints();
    gbc.gridx = 0;
    gbc.gridy = 0;
    gbc.anchor = GridBagConstraints.WEST;
    gbc.insets = new Insets(5, 5, 5, 5);

    inputPanel.add(new JLabel(LABEL_FLOOR), gbc);
    gbc.gridx++;
    floorField = new JTextField(10);
    inputPanel.add(floorField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel(LABEL_BOOKCASE), gbc);
    gbc.gridx++;
    bookcaseField = new JTextField(10);
    inputPanel.add(bookcaseField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Полка:"), gbc);
    gbc.gridx++;
    shelfField = new JTextField(10);
    inputPanel.add(shelfField, gbc);

    return inputPanel;
  }

  private void updateBookPlace(BookPlace bookPlace) {
    libraryDB.updateBookPlace(bookPlace);
  }

  private void deleteBookPlace(BookPlace bookPlace) {
    libraryDB.deleteBookPlace(bookPlace);
  }

  private void showEditDeletePlaceDialog() {
    Object[] options = {"Изменить", "Удалить"};
    int choice = JOptionPane.showOptionDialog(this,
        "Выберите действие для места книги:",
        "Изменение/Удаление места книги",
        JOptionPane.YES_NO_OPTION,
        JOptionPane.QUESTION_MESSAGE,
        null,
        options,
        options[0]);

    if (choice == JOptionPane.YES_OPTION) {
      if (selectedBookPlace != null) {
        showEditBookPlaceDialog(selectedBookPlace);
      }
    } else if (choice == JOptionPane.NO_OPTION && selectedBookPlace != null) {
      int confirmChoice = JOptionPane.showConfirmDialog(this,
          "Вы уверены, что хотите удалить место книги?",
          "Подтверждение удаления",
          JOptionPane.YES_NO_OPTION);
      if (confirmChoice == JOptionPane.YES_OPTION) {
        deleteBookPlace(selectedBookPlace);
      }
    }
  }

  private void showEditBookPlaceDialog(BookPlace bookPlace) {
    JPanel inputPanel = new JPanel(new GridBagLayout());
    GridBagConstraints gbc = new GridBagConstraints();
    gbc.gridx = 0;
    gbc.gridy = 0;
    gbc.anchor = GridBagConstraints.WEST;
    gbc.insets = new Insets(5, 5, 5, 5);

    JLabel floorLabel = new JLabel(LABEL_FLOOR);
    JTextField floorTextField = new JTextField(String.valueOf(bookPlace.getFloor()), 10);
    inputPanel.add(floorLabel, gbc);
    gbc.gridx++;
    inputPanel.add(floorTextField, gbc);

    JLabel bookcaseLabel = new JLabel(LABEL_BOOKCASE);
    JTextField bookcaseTextField = new JTextField(String.valueOf(bookPlace.getBookcase()), 10);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(bookcaseLabel, gbc);
    gbc.gridx++;
    inputPanel.add(bookcaseTextField, gbc);

    JLabel shelfLabel = new JLabel("Полка:");
    JTextField shelfTextField = new JTextField(String.valueOf(bookPlace.getShelf()), 10);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(shelfLabel, gbc);
    gbc.gridx++;
    inputPanel.add(shelfTextField, gbc);

    int result = JOptionPane.showConfirmDialog(this, inputPanel, "Изменить место книги",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int newFloor = Integer.parseInt(floorTextField.getText());
        int newBookcase = Integer.parseInt(bookcaseTextField.getText());
        int newShelf = Integer.parseInt(shelfTextField.getText());

        BookPlace newBookPlace = new BookPlace(newFloor, newBookcase, newShelf);

        // Проверка наличия комбинации места книги в базе данных
        if (libraryDB.isBookPlaceExists(newBookPlace)) {
          JOptionPane.showMessageDialog(this,
              "Место с такой комбинацией этажа, шкафа и полки уже существует!");
        } else {
          selectedBookPlace.setFloor(newFloor);
          selectedBookPlace.setBookcase(newBookcase);
          selectedBookPlace.setShelf(newShelf);

          updateBookPlace(selectedBookPlace);
        }
      } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this, "Ошибка при изменении места книги: " + e.getMessage());
      }
    }
  }

  private void addBook() {
    JPanel inputPanel = new JPanel(new GridBagLayout());
    GridBagConstraints gbc = new GridBagConstraints();
    gbc.gridx = 0;
    gbc.gridy = 0;
    gbc.anchor = GridBagConstraints.WEST;
    gbc.insets = new Insets(5, 5, 5, 5);

    inputPanel.add(new JLabel("Место:"), gbc);
    gbc.gridx++;
    JTextField placeIdField = new JTextField(10);
    inputPanel.add(placeIdField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Автор:"), gbc);
    gbc.gridx++;
    JTextField authorField = new JTextField(20);
    inputPanel.add(authorField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Название издания:"), gbc);
    gbc.gridx++;
    JTextField titleField = new JTextField(20);
    inputPanel.add(titleField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Издательство:"), gbc);
    gbc.gridx++;
    JTextField publisherField = new JTextField(20);
    inputPanel.add(publisherField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Год издания:"), gbc);
    gbc.gridx++;
    JTextField publicationYearField = new JTextField(10);
    inputPanel.add(publicationYearField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Количество страниц:"), gbc);
    gbc.gridx++;
    JTextField numPagesField = new JTextField(10);
    inputPanel.add(numPagesField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Год написания:"), gbc);
    gbc.gridx++;
    JTextField writingYearField = new JTextField(10);
    inputPanel.add(writingYearField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel("Вес (граммы):"), gbc);
    gbc.gridx++;
    JTextField weightGramsField = new JTextField(10);
    inputPanel.add(weightGramsField, gbc);

    int result = JOptionPane.showConfirmDialog(this, inputPanel, "Добавить книгу",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int placeId = Integer.parseInt(placeIdField.getText());
        String author = authorField.getText();
        String title = titleField.getText();
        String publisher = publisherField.getText();
        int publicationYear = Integer.parseInt(publicationYearField.getText());
        int numPages = Integer.parseInt(numPagesField.getText());
        int writingYear = Integer.parseInt(writingYearField.getText());
        int weightGrams = Integer.parseInt(weightGramsField.getText());

        BookPlace bookPlace = libraryDB.getBookPlaceId(placeId);
        if (bookPlace == null) {
          JOptionPane.showMessageDialog(this, "Место не найдено!");
          return;
        }

        Book book = new Book(bookPlace, author, title, publisher, publicationYear, numPages,
            writingYear, weightGrams);
        libraryDB.addBook(book);

        JOptionPane.showMessageDialog(this, "Книга успешно добавлена!");
      } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this,
            INVALID_INPUT_MESSAGE);
      }
    }
  }

  private void updateBook(Book book) {
    libraryDB.updateBook(book);
  }

  private void deleteBook(Book book) {
    libraryDB.deleteBook(book);
  }

  private void showEditDeleteDialog() {
    Object[] options = {"Изменить", "Удалить"};
    int choice = JOptionPane.showOptionDialog(this,
        "Выберите действие для книги:",
        "Изменение/Удаление книги",
        JOptionPane.YES_NO_OPTION,
        JOptionPane.QUESTION_MESSAGE,
        null,
        options,
        options[0]);

    if (choice == JOptionPane.YES_OPTION) {
      if (selectedBook != null) {
        showEditBookDialog(selectedBook);
      }
    } else if (choice == JOptionPane.NO_OPTION && (selectedBook != null)) {
      int confirmChoice = JOptionPane.showConfirmDialog(this,
          "Вы уверены, что хотите удалить книгу?",
          "Подтверждение удаления",
          JOptionPane.YES_NO_OPTION);
      if (confirmChoice == JOptionPane.YES_OPTION) {
        deleteBook(selectedBook);
      }
    }
  }

  private void showEditBookDialog(Book book) {
    JPanel inputPanel = new JPanel(new GridBagLayout());
    GridBagConstraints gbc = new GridBagConstraints();
    gbc.gridx = 0;
    gbc.gridy = 0;
    gbc.anchor = GridBagConstraints.WEST;
    gbc.insets = new Insets(5, 5, 5, 5);

    JLabel placeLabel = new JLabel("Место книги:");
    JTextField placeField = new JTextField(String.valueOf(book.getBookPlace().getBookPlaceId()),
        10);
    inputPanel.add(placeLabel, gbc);
    gbc.gridx++;
    inputPanel.add(placeField, gbc);

    JLabel authorLabel = new JLabel("Автор:");
    JTextField authorField = new JTextField(book.getAuthor(), 20);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(authorLabel, gbc);
    gbc.gridx++;
    inputPanel.add(authorField, gbc);

    JLabel titleLabel = new JLabel("Название издания:");
    JTextField titleField = new JTextField(book.getTitle(), 20);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(titleLabel, gbc);
    gbc.gridx++;
    inputPanel.add(titleField, gbc);

    JLabel publishingLabel = new JLabel("Издательство:");
    JTextField publishingField = new JTextField(book.getTitle(), 20);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(publishingLabel, gbc);
    gbc.gridx++;
    inputPanel.add(publishingField, gbc);

    JLabel yearLabel = new JLabel("Год:");
    JTextField yearField = new JTextField(String.valueOf(book.getPublicationYear()), 10);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(yearLabel, gbc);
    gbc.gridx++;
    inputPanel.add(yearField, gbc);

    JLabel numPagesLabel = new JLabel("Количество страниц:");
    JTextField numPagesField = new JTextField(String.valueOf(book.getNumPages()), 10);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(numPagesLabel, gbc);
    gbc.gridx++;
    inputPanel.add(numPagesField, gbc);

    JLabel writingYearLabel = new JLabel("Год написания:");
    JTextField writingYearField = new JTextField(String.valueOf(book.getWritingYear()), 10);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(writingYearLabel, gbc);
    gbc.gridx++;
    inputPanel.add(writingYearField, gbc);

    JLabel weightLabel = new JLabel("Вес (граммы):");
    JTextField weightField = new JTextField(String.valueOf(book.getWeightGrams()), 10);
    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(weightLabel, gbc);
    gbc.gridx++;
    inputPanel.add(weightField, gbc);

    int result = JOptionPane.showConfirmDialog(this, inputPanel, "Изменить книгу",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int newPlaceId = Integer.parseInt(placeField.getText());
        String newAuthor = authorField.getText();
        String newTitle = titleField.getText();
        String newPublisher = publishingField.getText();
        int publicationYear = Integer.parseInt(yearField.getText());
        int numPages = Integer.parseInt(numPagesField.getText());
        int writingYear = Integer.parseInt(writingYearField.getText());
        int weightGrams = Integer.parseInt(weightField.getText());

        selectedBook.getBookPlace().setBookPlaceId(newPlaceId);
        selectedBook.setAuthor(newAuthor);
        selectedBook.setTitle(newTitle);
        selectedBook.setPublisher(newPublisher);
        selectedBook.setPublicationYear(publicationYear);
        selectedBook.setNumPages(numPages);
        selectedBook.setWritingYear(writingYear);
        selectedBook.setWeightGrams(weightGrams);

        updateBook(selectedBook);
      } catch (Exception e) {
        JOptionPane.showMessageDialog(this, "Ошибка при изменении книги: " + e.getMessage());
      }
    }
  }

  private void getBooksByPlace() {
    JPanel inputPanel = new JPanel(new GridBagLayout());
    GridBagConstraints gbc = new GridBagConstraints();
    gbc.gridx = 0;
    gbc.gridy = 0;
    gbc.anchor = GridBagConstraints.WEST;
    gbc.insets = new Insets(5, 5, 5, 5);

    inputPanel.add(new JLabel("ID места:"), gbc);
    gbc.gridx++;
    JTextField placeIdField = new JTextField(10);
    inputPanel.add(placeIdField, gbc);

    int result = JOptionPane.showConfirmDialog(this, inputPanel, "Показать книги по месту",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int placeId = Integer.parseInt(placeIdField.getText());
        List<Book> books = libraryDB.getBooksByPlace(placeId);
        displayBooks(books);
      } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this,
            INVALID_INPUT_MESSAGE);
      }
    }
  }

  private void getPublishersOnShelf() {
    JPanel inputPanel = createInputPanel();

    int result = JOptionPane.showConfirmDialog(this, inputPanel, "Показать издательства на полке",
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int floor = Integer.parseInt(floorField.getText());
        int bookcase = Integer.parseInt(bookcaseField.getText());
        int shelf = Integer.parseInt(shelfField.getText());
        List<String> publishers = libraryDB.getPublishersOnShelf(floor, bookcase, shelf);
        displayPublishersTable(publishers);
      } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this,
            INVALID_INPUT_MESSAGE);
      }
    }
  }

  private void displayPublishersTable(List<String> publishers) {
    if (publishers.isEmpty()) {
      JOptionPane.showMessageDialog(this, "На данной полке нет книг от издателей.");
    } else {
      String[] columnNames = {"Издательство"};
      Object[][] data = new Object[publishers.size()][1];

      for (int i = 0; i < publishers.size(); i++) {
        data[i][0] = publishers.get(i);
      }

      DefaultTableModel tableModel = new DefaultTableModel(data, columnNames);
      JTable publishersTable = new JTable(tableModel);
      JScrollPane scrollPane = new JScrollPane(publishersTable);
      publishersTable.setFillsViewportHeight(true);

      JPanel mainPanel = (JPanel) getContentPane().getComponent(0);
      if (mainPanel.getComponentCount() > 1) {
        mainPanel.remove(1);
      }
      mainPanel.add(scrollPane, BorderLayout.CENTER);
      mainPanel.revalidate();
      mainPanel.repaint();
    }
  }

  private void getAllBooks() {
    List<Book> books = libraryDB.getAllBooks();
    displayBooks(books);
  }

  private void displayBooks(List<Book> books) {
    if (books.isEmpty()) {
      JOptionPane.showMessageDialog(this, "В данном месте нет книг!");
    } else {
      DefaultTableModel tableModel = createTableModel(books);
      JTable bookTable = new JTable(tableModel);
      JScrollPane scrollPane = new JScrollPane(bookTable);
      bookTable.setFillsViewportHeight(true);

      JPanel mainPanel = (JPanel) getContentPane().getComponent(0);
      if (mainPanel.getComponentCount() > 1) {
        mainPanel.remove(1);
      }
      mainPanel.add(scrollPane, BorderLayout.CENTER);
      mainPanel.revalidate();
      mainPanel.repaint();

      bookTable.addMouseListener(new MouseAdapter() {
        @Override
        public void mouseClicked(MouseEvent e) {
          int selectedRow = bookTable.getSelectedRow();
          if (selectedRow != -1) {
            selectedBook = books.get(selectedRow);
            showEditDeleteDialog();
          }
        }
      });
    }
  }

  private void getAllBookPlaces() {
    List<BookPlace> bookPlaces = libraryDB.getAllBookPlaces();
    displayBookPlaces(bookPlaces);
  }

  private void displayBookPlaces(List<BookPlace> bookPlaces) {
    if (bookPlaces.isEmpty()) {
      JOptionPane.showMessageDialog(this, "Нет доступных мест!");
    } else {
      DefaultTableModel tableModel = createBookPlaceTableModel(bookPlaces);
      JTable bookPlaceTable = new JTable(tableModel);
      JScrollPane scrollPane = new JScrollPane(bookPlaceTable);
      bookPlaceTable.setFillsViewportHeight(true);

      JPanel mainPanel = (JPanel) getContentPane().getComponent(0);
      if (mainPanel.getComponentCount() > 1) {
        mainPanel.remove(1);
      }
      mainPanel.add(scrollPane, BorderLayout.CENTER);
      mainPanel.revalidate();
      mainPanel.repaint();

      bookPlaceTable.addMouseListener(new MouseAdapter() {
        @Override
        public void mouseClicked(MouseEvent e) {
          int selectedRow = bookPlaceTable.getSelectedRow();
          if (selectedRow != -1) {
            selectedBookPlace = bookPlaces.get(selectedRow);
            showEditDeletePlaceDialog();
          }
        }
      });
    }
  }

  private DefaultTableModel createBookPlaceTableModel(List<BookPlace> bookPlaces) {
    String[] columnNames = {"ID", "Этаж", "Шкаф", "Полка"};
    Object[][] data = new Object[bookPlaces.size()][columnNames.length];

    for (int i = 0; i < bookPlaces.size(); i++) {
      BookPlace bookPlace = bookPlaces.get(i);
      data[i][0] = bookPlace.getBookPlaceId();
      data[i][1] = bookPlace.getFloor();
      data[i][2] = bookPlace.getBookcase();
      data[i][3] = bookPlace.getShelf();
    }

    return new DefaultTableModel(data, columnNames);
  }

  private DefaultTableModel createTableModel(List<Book> books) {
    String[] columnNames = {"ID", "Место", "Автор", "Название издания", "Издательство",
        "Год издания", "Количество страниц", "Год написания", "Вес (граммы)"};
    Object[][] data = new Object[books.size()][columnNames.length];

    for (int i = 0; i < books.size(); i++) {
      Book book = books.get(i);
      data[i][0] = book.getBookId();
      data[i][1] = book.getBookPlace().toString();
      data[i][2] = book.getAuthor();
      data[i][3] = book.getTitle();
      data[i][4] = book.getPublisher();
      data[i][5] = book.getPublicationYear();
      data[i][6] = book.getNumPages();
      data[i][7] = book.getWritingYear();
      data[i][8] = book.getWeightGrams();
    }

    return new DefaultTableModel(data, columnNames);
  }

  private void getBookByType(boolean isHeaviest) {
    String title = isHeaviest ? "Показать самую тяжелую книгу" : "Показать самую легкую книгу";

    JPanel inputPanel = new JPanel(new GridBagLayout());
    GridBagConstraints gbc = new GridBagConstraints();
    gbc.gridx = 0;
    gbc.gridy = 0;
    gbc.anchor = GridBagConstraints.WEST;
    gbc.insets = new Insets(5, 5, 5, 5);

    inputPanel.add(new JLabel(LABEL_FLOOR), gbc);
    gbc.gridx++;
    JTextField floorTextField = new JTextField(10);
    inputPanel.add(floorTextField, gbc);

    gbc.gridx = 0;
    gbc.gridy++;
    inputPanel.add(new JLabel(LABEL_BOOKCASE), gbc);
    gbc.gridx++;
    JTextField bookcaseTextField = new JTextField(10);
    inputPanel.add(bookcaseTextField, gbc);

    int result = JOptionPane.showConfirmDialog(this, inputPanel, title,
        JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

    if (result == JOptionPane.OK_OPTION) {
      try {
        int bookPlaceId = Integer.parseInt(floorTextField.getText());
        int bookcase = Integer.parseInt(bookcaseTextField.getText());
        Book book = isHeaviest ? libraryDB.getHeaviestBookInBookcase(bookPlaceId, bookcase)
            : libraryDB.getLightestBookInBookcase(bookPlaceId, bookcase);
        if (book != null) {
          List<Book> books = new ArrayList<>();
          books.add(book);
          displayBooks(books);
        }
      } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this, INVALID_INPUT_MESSAGE);
      }
    }
  }

  private void getHeaviestBook() {
    getBookByType(true);
  }

  private void getLightestBook() {
    getBookByType(false);
  }
}
