(* module Live = struct
  type t = {
    lesson_id: int;
    course_cd: string;
    class_:  string;
  }

  let t = 
    let encode {lesson_id; course_cd; class_} = Ok (lesson_id, course_cd, class_) in
    let decode (lesson_id, course_cd, class_) = Ok {lesson_id; course_cd; class_} in
    let rep = Caqti_type.(tup3 int string string) in
    Caqti_type.custom ~encode ~decode rep
end

module Q = struct
  let create_livereq = 
    Caqti_request.exec Caqti_type.unit
    {eos|
      CREATE TEMP TABLE livereg (
        lesson_id integer NOT NULL,
        course_cd text NOT NULL,
        class text NOT NULL
      )
    |eos}
  
  let reg_live = Caqti_request.exec
  Caqti_type.(tup3 int string string)
  "INSERT INTO livereg (lesson_id, course_cd, class) VALUES (?, ?, ?)"
end *)

module Live = Live