import express from 'express';
import pkg from 'pg';
import path from 'path';
import { fileURLToPath } from 'url';
import expressSession from 'express-session'; // เปลี่ยน require เป็น import

const { Pool } = pkg;
const app = express();

// แปลง __dirname ให้ใช้ได้ใน ES Modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// ตั้งค่า EJS เป็น view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// เสิร์ฟไฟล์ static
app.use(express.static(path.join(__dirname, 'public')));

app.use(express.urlencoded({ extended: true }));
app.use(express.json()); 

// ตั้งค่าการเชื่อมต่อ PostgreSQL
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'studentrecord',
  password: 'bigCextra',
  port: 5432,
});

// ใช้ express-session แบบ import
app.use(expressSession({
  secret: '1234',
  resave: false,
  saveUninitialized: true,
}));

app.get('/login' ,async (req , res) => {
  res.sendFile(path.join(__dirname, 'login.html'));
});

// Login route
app.post('/login', async (req, res) => {

  const { email, telephone } = req.body;  

  try {
    const studentQuery = await pool.query('SELECT * FROM student WHERE email = $1', [email]);

    if (studentQuery.rows.length > 0) {
      const student = studentQuery.rows[0];

      if (telephone === student.telephone) {
        req.session.userId = student.id; 
        res.redirect('/');
      } else {
        res.send('Invalid email or telephone');
      }
    } else if (email == 'admin@gmail.com'){
      if (telephone == 'admin'){
        req.session.userId = 'admin';
        res.redirect('/admin'); 
      } else {
        res.send('Invalid email or telephone');
      }
    }
    else {
      res.send('Invalid email or telephone');
    }
  } catch (err) {
    console.error('Error during login:', err);
    res.status(500).send('Internal server error');
  }
});

app.post('/submit-checkin', async (req, res) => {
  const { id, section_id, student_id, date } = req.body;

  try {
    const result = await pool.query(
      `INSERT INTO student_list (id, section_id, student_id, active_date) 
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [id, section_id, student_id, date]
    );

    res.status(201).send('<script>alert("Check-in added successfully!"); window.location.href = "/";</script>');
  } catch (error) {
    console.error(error.message);
    res.status(500).send('<script>alert("Error adding check-in data."); window.location.href = "/checkin";</script>');
  }
});

app.get('/view-students', async (req, res) => {
  if (!req.session.userId) {
    return res.redirect('/login'); 
  }
  try {
      const result = await pool.query(`
        SELECT 
            student_list.id AS list_id,
            section.section, 
            student_list.student_id,
            student_list.active_date,
            student.first_name,
            student.last_name,
            student.email,
            student.telephone
        FROM 
            student_list
        JOIN 
            student 
        ON 
            student_list.id = student.id
        JOIN 
            section
        ON 
            student_list.id = section.id;
      `);
      
      const students = result.rows; // ข้อมูลนักเรียนทั้งหมดที่ join แล้ว

      // ส่งข้อมูลไปยัง list.ejs เพื่อแสดงผล
      res.render('list', { students });
  } catch (err) {
      console.error(err.message);
      res.status(500).send('Server Error');
  }
});



// Home route
app.get('/', async (req, res) => {
  if (!req.session.userId) {
    return res.redirect('/login'); 
  }

  try {
    // ดึงข้อมูลของนักเรียนจากฐานข้อมูล
    const studentQuery = await pool.query(`SELECT 
        student.id,
        prefix.prefix AS prefix,
        student.first_name,
        student.last_name,
        student.date_of_birth,
        student.sex,
        student.previous_school,
        student.address,
        student.telephone,
        student.email,
        student.line_id,
        student.curriculum_id,
        curriculum.curr_name_th,
        curriculum.curr_name_en,
        curriculum.short_name_th,
        curriculum.short_name_en
      FROM 
          student
      JOIN 
          prefix 
      ON 
          student.prefix_id = prefix.id
      JOIN 
          curriculum
      ON 
          student.curriculum_id = curriculum.id
      WHERE 
          student.id = $1;`, [req.session.userId]);
    const student = studentQuery.rows[0];

    if (student) {
      // ส่งข้อมูลไปยัง index.ejs เพื่อแสดงผล
      res.render('index', { student });
    } else {
      res.send('Student not found');
    }
  } catch (err) {
    console.error('Error fetching student data:', err);
    res.status(500).send('Internal server error');
  }
});

app.get('/admin', async (req , res) => {
  if (!req.session.userId) {
    return res.redirect('/login'); 
  }

  res.render('admin');
});

app.get('/checkin', (req, res) => {
  if (!req.session.userId) {
    return res.redirect('/login'); 
  }
  res.sendFile(path.join(__dirname, 'checkin.html'));
});


// Logout route
app.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/');
});

app.post('/add-student', async (req, res) => {
  const { id , prefix_id, first_name, last_name, date_of_birth, sex, previous_school, address, telephone, email, line_id, curriculum_id} = req.body;

  try {
      // คำสั่ง SQL สำหรับเพิ่มนักเรียนใหม่ลงในตาราง student
      const newStudent = await pool.query(
        `INSERT INTO student (id, prefix_id, first_name, last_name, date_of_birth, sex, previous_school, address, telephone, email, line_id, curriculum_id) 
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10 , $11 , $12) RETURNING *`,
        [id , prefix_id, first_name, last_name, date_of_birth, sex, previous_school, address, telephone, email, line_id, curriculum_id]
      );      

      // ถ้าเพิ่มนักเรียนสำเร็จ ให้แสดง alert และเปลี่ยนเส้นทางไปที่หน้าอื่น
      res.send(`
        <script>
          alert('Student added successfully');
          window.location.href = '/admin';
        </script>
      `);
  } catch (err) {
      console.error(err.message);

      // ถ้ามีข้อผิดพลาด ให้แสดง alert พร้อมข้อความแสดงข้อผิดพลาด
      res.send(`
        <script>
          alert('Error adding student: ${err.message}');
          window.location.href = '/admin';
        </script>
      `);
  }
});

app.get('/clear', async (req,res) => {
  if (!req.session.userId) {
    return res.redirect('/login'); 
  }

  try{

    await pool.query(
      `TRUNCATE TABLE student_list`
    );      

    res.send(`
      <script>
        alert('Student clear successfully');
        window.location.href = '/admin';
      </script>
    `);
    
  }catch{
    res.send(`
      <script>
        alert('Error clearing student: ${err.message}');
        window.location.href = '/admin';
      </script>
    `);
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

