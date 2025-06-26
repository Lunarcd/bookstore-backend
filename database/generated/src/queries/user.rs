// This file was generated with `clorinde`. Do not modify.

#[derive(serde::Serialize, Debug, Clone, PartialEq)]
pub struct User {
    pub id: uuid::Uuid,
    pub email: String,
    pub password: String,
    pub fname: String,
    pub lname: String,
    pub dob: Option<crate::types::time::Date>,
    pub role: ctypes::Role,
    pub created_at: crate::types::time::TimestampTz,
    pub updated_at: crate::types::time::TimestampTz,
}
pub struct UserBorrowed<'a> {
    pub id: uuid::Uuid,
    pub email: &'a str,
    pub password: &'a str,
    pub fname: &'a str,
    pub lname: &'a str,
    pub dob: Option<crate::types::time::Date>,
    pub role: ctypes::Role,
    pub created_at: crate::types::time::TimestampTz,
    pub updated_at: crate::types::time::TimestampTz,
}
impl<'a> From<UserBorrowed<'a>> for User {
    fn from(
        UserBorrowed {
            id,
            email,
            password,
            fname,
            lname,
            dob,
            role,
            created_at,
            updated_at,
        }: UserBorrowed<'a>,
    ) -> Self {
        Self {
            id,
            email: email.into(),
            password: password.into(),
            fname: fname.into(),
            lname: lname.into(),
            dob,
            role,
            created_at,
            updated_at,
        }
    }
}
use crate::client::async_::GenericClient;
use futures::{self, StreamExt, TryStreamExt};
pub struct UserQuery<'c, 'a, 's, C: GenericClient, T, const N: usize> {
    client: &'c C,
    params: [&'a (dyn postgres_types::ToSql + Sync); N],
    stmt: &'s mut crate::client::async_::Stmt,
    extractor: fn(&tokio_postgres::Row) -> Result<UserBorrowed, tokio_postgres::Error>,
    mapper: fn(UserBorrowed) -> T,
}
impl<'c, 'a, 's, C, T: 'c, const N: usize> UserQuery<'c, 'a, 's, C, T, N>
where
    C: GenericClient,
{
    pub fn map<R>(self, mapper: fn(UserBorrowed) -> R) -> UserQuery<'c, 'a, 's, C, R, N> {
        UserQuery {
            client: self.client,
            params: self.params,
            stmt: self.stmt,
            extractor: self.extractor,
            mapper,
        }
    }
    pub async fn one(self) -> Result<T, tokio_postgres::Error> {
        let stmt = self.stmt.prepare(self.client).await?;
        let row = self.client.query_one(stmt, &self.params).await?;
        Ok((self.mapper)((self.extractor)(&row)?))
    }
    pub async fn all(self) -> Result<Vec<T>, tokio_postgres::Error> {
        self.iter().await?.try_collect().await
    }
    pub async fn opt(self) -> Result<Option<T>, tokio_postgres::Error> {
        let stmt = self.stmt.prepare(self.client).await?;
        Ok(self
            .client
            .query_opt(stmt, &self.params)
            .await?
            .map(|row| {
                let extracted = (self.extractor)(&row)?;
                Ok((self.mapper)(extracted))
            })
            .transpose()?)
    }
    pub async fn iter(
        self,
    ) -> Result<
        impl futures::Stream<Item = Result<T, tokio_postgres::Error>> + 'c,
        tokio_postgres::Error,
    > {
        let stmt = self.stmt.prepare(self.client).await?;
        let it = self
            .client
            .query_raw(stmt, crate::slice_iter(&self.params))
            .await?
            .map(move |res| {
                res.and_then(|row| {
                    let extracted = (self.extractor)(&row)?;
                    Ok((self.mapper)(extracted))
                })
            })
            .into_stream();
        Ok(it)
    }
}
pub fn get() -> GetStmt {
    GetStmt(crate::client::async_::Stmt::new(
        "SELECT * FROM users WHERE id = $1",
    ))
}
pub struct GetStmt(crate::client::async_::Stmt);
impl GetStmt {
    pub fn bind<'c, 'a, 's, C: GenericClient>(
        &'s mut self,
        client: &'c C,
        id: &'a uuid::Uuid,
    ) -> UserQuery<'c, 'a, 's, C, User, 1> {
        UserQuery {
            client,
            params: [id],
            stmt: &mut self.0,
            extractor: |row: &tokio_postgres::Row| -> Result<UserBorrowed, tokio_postgres::Error> {
                Ok(UserBorrowed {
                    id: row.try_get(0)?,
                    email: row.try_get(1)?,
                    password: row.try_get(2)?,
                    fname: row.try_get(3)?,
                    lname: row.try_get(4)?,
                    dob: row.try_get(5)?,
                    role: row.try_get(6)?,
                    created_at: row.try_get(7)?,
                    updated_at: row.try_get(8)?,
                })
            },
            mapper: |it| User::from(it),
        }
    }
}
pub fn get_by_email() -> GetByEmailStmt {
    GetByEmailStmt(crate::client::async_::Stmt::new(
        "SELECT * FROM users WHERE email = $1",
    ))
}
pub struct GetByEmailStmt(crate::client::async_::Stmt);
impl GetByEmailStmt {
    pub fn bind<'c, 'a, 's, C: GenericClient, T1: crate::StringSql>(
        &'s mut self,
        client: &'c C,
        email: &'a T1,
    ) -> UserQuery<'c, 'a, 's, C, User, 1> {
        UserQuery {
            client,
            params: [email],
            stmt: &mut self.0,
            extractor: |row: &tokio_postgres::Row| -> Result<UserBorrowed, tokio_postgres::Error> {
                Ok(UserBorrowed {
                    id: row.try_get(0)?,
                    email: row.try_get(1)?,
                    password: row.try_get(2)?,
                    fname: row.try_get(3)?,
                    lname: row.try_get(4)?,
                    dob: row.try_get(5)?,
                    role: row.try_get(6)?,
                    created_at: row.try_get(7)?,
                    updated_at: row.try_get(8)?,
                })
            },
            mapper: |it| User::from(it),
        }
    }
}
